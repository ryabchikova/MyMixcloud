//
//  MixcloudError.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 19/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

struct MMError: Error {
    enum ErrorType: String {
        case noMatter
        case networkUnreachable
        case webServiceError
        case decodingError
        case executionError
    }
    
    let type: ErrorType
    let location: String?
    let what: String?
    
    init(type: ErrorType, location: String? = nil, what: String? = nil) {
        self.type = type
        self.location = location
        self.what = what
    }
    
    func log() {
        NSLog("[%@] [%@] %@", location ?? "", type.rawValue, what ?? "" )
    }
}

extension MMError {

    static let noMatter = MMError(type: .noMatter)
    static let networkUnreachable = MMError(type: .networkUnreachable)
    static let webServiceError = MMError(type: .webServiceError)
    static let decodingError = MMError(type: .decodingError)
    static let executionError = MMError(type: .executionError)

}
