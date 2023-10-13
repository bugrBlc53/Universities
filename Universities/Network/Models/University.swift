//
//  University.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 13.10.2023.
//

import Foundation

struct University: Codable, Hashable {
    let webPages: [String]?
    let name: String?
    let domains: [String]?
    
    enum CodingKeys: String, CodingKey {
        case webPages = "web_pages"
        case name, domains
    }
}
