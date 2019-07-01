//
//  TrackListContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackListContainer {
    let input: TrackListModuleInput
	let viewController: UIViewController
	private(set) weak var router: TrackListRouterInput!

	class func assemble(with context: TrackListContext) -> TrackListContainer {
        let router = TrackListRouter()
        // TODO there is work for DI container !!!
        let interactor = TrackListInteractor(trackService: TrackServiceImpl())
        let presenter = TrackListPresenter(router: router,
                                           interactor: interactor,
                                           userId: context.userId,
                                           trackListType: context.trackListType)
		let viewController = TrackListViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TrackListContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TrackListModuleInput, router: TrackListRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TrackListContext {
	weak var moduleOutput: TrackListModuleOutput?
    let userId: String
    let trackListType: TrackListType
}

enum TrackListType {
    case history, favorite
}
