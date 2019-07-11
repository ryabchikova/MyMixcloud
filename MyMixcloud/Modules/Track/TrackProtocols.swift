//
//  TrackProtocols.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 11/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol TrackModuleInput {
	var moduleOutput: TrackModuleOutput? { get }
}

protocol TrackModuleOutput: class {
}

protocol TrackViewInput: class {
}

protocol TrackViewOutput: class {
}

protocol TrackInteractorInput: class {
}

protocol TrackInteractorOutput: class {
}

protocol TrackRouterInput: class {
}
