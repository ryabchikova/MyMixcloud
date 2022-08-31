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
    
    @discardableResult
    func log() -> Self {
        NSLog("[%@] [%@] %@", location ?? "", type.rawValue, what ?? "" )
        return self
    }
}

extension MMError {

    static let noMatter = MMError(type: .noMatter)
    static let networkUnreachable = MMError(type: .networkUnreachable)
    static let webServiceError = MMError(type: .webServiceError)
    static let decodingError = MMError(type: .decodingError)
    static let executionError = MMError(type: .executionError)
    
    static func decodingError(_ error: Error, at location: String? = nil) -> Self {
        MMError(type: .decodingError,
                location: location,
                what: (error as? DecodingError)?.localizedDescription)
    }
    
    /// When network request failed
    static func requestError(_ isNetworkReachable: Bool, at location: String? = nil) -> Self {
        MMError(type: isNetworkReachable ? .webServiceError : .networkUnreachable,
                location: location)
    }

}
