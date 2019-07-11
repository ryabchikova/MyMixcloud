//
//  TrackContainer.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackContainer {
    let input: TrackModuleInput
	let viewController: UIViewController
	private(set) weak var router: TrackRouterInput!

	class func assemble(with context: TrackContext) -> TrackContainer {
        let router = TrackRouter()
        let interactor = TrackInteractor(trackService: InjectionManager.shared.trackService())
        let presenter = TrackPresenter(router: router, interactor: interactor, trackId: context.trackId)
		let viewController = TrackViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TrackContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TrackModuleInput, router: TrackRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TrackContext {
	weak var moduleOutput: TrackModuleOutput?
    let trackId: String
}
