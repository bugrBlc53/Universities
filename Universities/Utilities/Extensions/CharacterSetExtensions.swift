//
//  CharacterSetExtensions.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 13.10.2023.
//

import Foundation

extension CharacterSet {
    static let urlQueryCalueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowed: CharacterSet = .urlQueryAllowed
        
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
