//
//  FollowingPresenter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 28/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

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
    
    private func requestNextPage() {
        guard !isLoading, let nextPage = nextPage else {
            return
        }
        
        isLoading = true
        interactor.loadFollowing(userId: userId, page: nextPage)
    }
}

extension FollowingPresenter: FollowingInteractorOutput {
    func gotError(_ error: Error?) {
        isLoading = false
        view?.showDummyView()
    }
    
    func didLoadFollowing(_ users: [User]) {
        isLoading = false
        nextPage = users.isEmpty ? nil : nextPage?.advanced(by: 1)
        view?.set(viewModels: users.map { FollowingUserViewModel(user: $0) })
    }
}
