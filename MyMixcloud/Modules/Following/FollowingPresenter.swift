//
//  FollowingPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation
import UIKit

final class FollowingPresenter {    
	weak var view: FollowingViewInput?
    weak var moduleOutput: FollowingModuleOutput?
	private let router: FollowingRouterInput
	private let interactor: FollowingInteractorInput
    
    private let userId: String
    private var nextPage: Int? = 1
    private var isLoading = false
    
    init(router: FollowingRouterInput, interactor: FollowingInteractorInput, userId: String) {
        self.router = router
        self.interactor = interactor
        self.userId = userId
    }
}

extension FollowingPresenter: FollowingModuleInput {
}

extension FollowingPresenter: FollowingViewOutput {
    func viewDidLoad() {
        requestNextPage()
    }
    
    func viewDidScrollPage() {
        requestNextPage()
    }
    
    func didPullToRefresh() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        interactor.loadFollowing(userId: userId, page: 1, reason: .pullToRefresh)
    }
    
    private func requestNextPage() {
        guard !isLoading, let nextPage = nextPage else {
            return
        }
        
        isLoading = true
        interactor.loadFollowing(userId: userId, page: nextPage, reason: .regular)
    }
    
    func didTapOnUser(with userId: String) {
        if let viewController = view as? UIViewController {
            router.showUserProfileScreen(in: viewController, userId: userId)
        }
    }
}

extension FollowingPresenter: FollowingInteractorOutput {
    func gotError() {
        isLoading = false
    }
    
    func didLoadFollowing(_ users: [User], reason: LoadingReason) {
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
