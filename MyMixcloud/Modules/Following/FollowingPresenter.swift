//
//  FollowingPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class FollowingPresenter {    
	weak var view: FollowingViewInput?

	private let router: FollowingRouterInput
	private let interactor: FollowingInteractorInput
    private weak var moduleOutput: FollowingModuleOutput?
    
    private let userId: String
    private var nextPage: Int? = 1
    private var isLoading = false       // TODO: подходит под паттерн lock/unlock
                                        // TODO: interactor похож на actor, с собственным lock
    
    var viewIsEmpty: Bool {
        return view?.isEmpty ?? false
    }
    
    init(router: FollowingRouterInput,
         interactor: FollowingInteractorInput,
         moduleOutput: FollowingModuleOutput?,
         userId: String
    ) {
        self.router = router
        self.interactor = interactor
        self.moduleOutput = moduleOutput
        self.userId = userId
    }
}

extension FollowingPresenter: FollowingModuleInput {}

extension FollowingPresenter: FollowingViewOutput {
    func viewWillAppear() {
        if viewIsEmpty {
            requestNextPage()
        }
    }
    
    func viewDidScrollPage() {
        requestNextPage()
    }
    
    func didPullToRefresh() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        interactor.loadFollowing(userId: userId, page: 1, reason: .pullToRefresh, useCache: viewIsEmpty)
    }
    
    private func requestNextPage() {
        guard !isLoading, let nextPage = nextPage else {
            return
        }
        isLoading = true
        interactor.loadFollowing(userId: userId, page: nextPage, reason: .regular, useCache: viewIsEmpty)
    }
    
    func didTapOnUser(with userId: String) {
        if let viewController = view as? UIViewController {
            router.showUserProfileScreen(in: viewController, userId: userId)
        }
    }
}

extension FollowingPresenter: FollowingInteractorOutput {
    func gotError(_ error: MMError) {
        isLoading = false
        if let viewController = view, viewController.isEmpty {
            viewController.showDummyView(for: error) { [weak self] in
                self?.requestNextPage()
            }
        }
    }
    
    func didLoadFollowing(_ users: [User], reason: LoadingReason) {
        view?.hideDummyViewIfNeed()
        
        let viewModels = users.map { FollowingUserViewModel(user: $0) }
        switch reason {
        case .regular:
            nextPage = users.isEmpty ? nil : nextPage?.advanced(by: 1)
            view?.set(viewModels: viewModels)
        case .pullToRefresh:
            nextPage = 2
            view?.reset(viewModels: viewModels)
        }

        isLoading = false
    }
}
