//
//  TrackModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

struct TrackModuleBuilder {
    
    private init() {}

	static func build(_ context: TrackContext,
                      moduleOutput: TrackModuleOutput? = nil) -> Module<TrackModuleInput> {
        let interactor = TrackInteractor(trackService: InjectionManager.shared.trackService())
        let presenter = TrackPresenter(interactor: interactor,
                                       moduleOutput: moduleOutput,
                                       context: context)
		let viewController = TrackViewController(output: presenter)

		presenter.view = viewController
		interactor.output = presenter

        return Module(viewController, presenter)
	}

}

struct TrackContext {
    let trackId: String
}
