//
//  JsonTrackList.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 29/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct JsonTrackList: Decodable {
    
    let tracks: [JsonTrack]
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "data"
    }
}
