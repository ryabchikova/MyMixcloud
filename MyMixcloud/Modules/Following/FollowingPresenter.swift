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

	private let router: Router
	private let interactor: FollowingInteractorInput
    private weak var moduleOutput: FollowingModuleOutput?
    
    private let userId: String
    private var nextPage: Int? = 1
    
    var viewIsEmpty: Bool {
        return view?.isEmpty ?? false
    }
    
    init(router: Router,
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
        interactor.loadFollowing(userId: userId, page: 1, reason: .pullToRefresh)
    }
    
    private func requestNextPage() {
        guard let nextPage = nextPage else {
            return
        }

        interactor.loadFollowing(userId: userId, page: nextPage, reason: .regular)
    }
    
    func didTapOnUser(with userId: String) {
        router.showUserProfileScreen(userId: userId, isMyProfile: false)
    }
}

extension FollowingPresenter: FollowingInteractorOutput {
    @MainActor
    func gotError(_ error: MMError) async {
        guard viewIsEmpty else {
            return
        }
        
        view?.showDummyView(for: error) { [weak self] in
            self?.requestNextPage()
        }
    }
    
    @MainActor
    func didLoadFollowing(_ users: [User], reason: LoadingReason) async {
        view?.hideDummyViewIfNeed()
        
        let viewModels = users.map { FollowingUserViewModel(user: $0) }
        nextPage = users.isEmpty ? nil : nextPage?.advanced(by: 1)
        
        switch reason {
        case .regular:
            view?.set(viewModels: viewModels)
        case .pullToRefresh:
            view?.reset(viewModels: viewModels)
        }
    }
}
