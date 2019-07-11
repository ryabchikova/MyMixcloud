//
//  TrackListRouter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 01/07/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import UIKit

final class TrackListRouter {
}

extension TrackListRouter: TrackListRouterInput {
    
    func showTrackScreen(in viewController: UIViewController, trackId: String) {
        let trackContainer = TrackContainer.assemble(with: TrackContext(moduleOutput: nil, trackId: trackId))
        viewController.show(trackContainer.viewController, sender: self)
    }
}
