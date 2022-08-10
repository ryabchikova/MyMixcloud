//
//  TrackModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

struct TrackModuleBuilder {
    
    private init() {}

	static func build(with context: TrackContext) -> Module<TrackModuleInput> {
        let interactor = TrackInteractor(trackService: InjectionManager.shared.trackService())
        let presenter = TrackPresenter(interactor: interactor, context: context)
		let viewController = TrackViewController(output: presenter)

		presenter.view = viewController
		interactor.output = presenter

        return Module(viewController, presenter)
	}

}

struct TrackContext {
	let moduleOutput: TrackModuleOutput?
    let trackId: String
    
    init(trackId: String, moduleOutput: TrackModuleOutput? = nil) {
        self.trackId = trackId
        self.moduleOutput = moduleOutput
    }
}
