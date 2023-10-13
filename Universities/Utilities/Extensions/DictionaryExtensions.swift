//
//  DictionaryExtensions.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 13.10.2023.
//

import Foundation

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryCalueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryCalueAllowed) ?? ""
            
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
