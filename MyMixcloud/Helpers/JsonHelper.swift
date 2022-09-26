//
//  JsonHelper.swift
//  MyMixcloud
//
//  Created by Elena Ryabchikova on 27.08.2022.
//  Copyright © 2022 ryabchikova. All rights reserved.
//

import Foundation

final class JsonHelper {

    /// Decodes JSON data to object with specified type
    ///
    /// - Parameter data: JSON data
    /// - Parameter keyDecodingStrategy: decoding strategy
    /// - Returns: object with specified type
    static func decodedData<T: Decodable>(
        _ data: Data,
        strategy: JSONDecoder.KeyDecodingStrategy? = nil) throws -> T {

        let decoder = JSONDecoder()
        if let strategy = strategy {
            decoder.keyDecodingStrategy = strategy
        }
        return try decoder.decode(T.self, from: data)
    }
    
    static func decodedSnakeCaseData<T: Decodable>(_ data: Data) throws -> T {
        try decodedData(data, strategy: .convertFromSnakeCase)
    }

}
