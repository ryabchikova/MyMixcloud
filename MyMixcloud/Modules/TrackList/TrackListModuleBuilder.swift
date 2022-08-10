//
//  TrackListModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//


struct TrackListModuleBuilder {
    
    private init() {}

	static func build(_ context: TrackListContext,
                      moduleOutput: TrackListModuleOutput? = nil) -> Module<TrackListModuleInput> {
        let router = TrackListRouter()
        let interactor = TrackListInteractor(trackService: InjectionManager.shared.trackService())
        let presenter = TrackListPresenter(router: router,
                                           interactor: interactor,
                                           moduleOutput: moduleOutput,
                                           context: context)
        
        let title = context.trackListType == .history ? "History" : "Favorite"
        let viewController = TrackListViewController(output: presenter, title: title)

		presenter.view = viewController
		interactor.output = presenter

        return Module(viewController, presenter)
	}

}

struct TrackListContext {
    let userId: String
    let trackListType: TrackListType
}

enum TrackListType {
    case history, favorite
}
