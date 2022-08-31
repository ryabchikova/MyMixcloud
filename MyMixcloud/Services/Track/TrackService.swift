//
//  TrackService.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

protocol TrackService {
    func track(trackId: String) async throws -> Track
    /// - parameter page: starting from 1
    func listeningHistory(userId: String, page: Int) async throws -> [Track]
    /// - parameter page: starting from 1
    func favoriteList(userId: String, page: Int) async throws -> [Track]
}
