//
//  UserProfileModuleBuilder.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 27/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

struct UserProfileModuleBuilder {

    private init() {}

	static func build(with context: UserProfileContext) -> Module<UserProfileModuleInput> {
        let router = UserProfileRouter()
        let interactor = UserProfileInteractor(userService: InjectionManager.shared.userService())
        let presenter = UserProfilePresenter(router: router, interactor: interactor, context: context)
        let viewController = UserProfileViewController(output: presenter, isMyProfile: context.isMyProfile)

		presenter.view = viewController
		interactor.output = presenter

        return Module(viewController, presenter)
	}

}

struct UserProfileContext {
	let moduleOutput: UserProfileModuleOutput?
    let userId: String
    let isMyProfile: Bool
    
    init(userId: String, isMyProfile: Bool, moduleOutput: UserProfileModuleOutput? = nil) {
        self.userId = userId
        self.isMyProfile = isMyProfile
        self.moduleOutput = moduleOutput
    }
}
