//
//  JsonDataConverter.swift
//  MyMixcloud
//
//  Created by Ryabchikova Elena on 25/06/2019.
//  Copyright © 2019 ryabchikova. All rights reserved.
//

import Foundation

final class JsonDataConverter {

    static func convertTimestamp(_ input: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM HH:mm"
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return inputFormatter.date(from: input).map { outputFormatter.string(from: $0) }
    }
    
    static func convertSecondsToReadableTime(_ input: Int) -> String? {
        guard input > 0 && input < 24*60*60 else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm:ss"
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return outputFormatter.string(from: Date(timeIntervalSince1970: Double(input)))
    }
}
