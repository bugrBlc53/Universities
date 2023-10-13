//
//  Enums.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 13.10.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Countries: String, CaseIterable {
    case turkiye = "turkey"
    case unitedStates = "united+states"
    case germany = "germany"
    case azerbaijan = "azerbaijan"
    case france = "france"
    case china = "china"
    case italy = "italy"
    case spain = "spain"
    case portugal = "portugal"
    case unitedKingdom = "united+kingdom"
    
    func getCountryName() -> String {
        switch self {
        case .turkiye:
            return "Türkiye"
        case .unitedStates:
            return "USA"
        case .germany:
            return "Germany"
        case .azerbaijan:
            return "Azerbaijan"
        case .france:
            return "France"
        case .china:
            return "China"
        case .italy:
            return "Italy"
        case .spain:
            return "Spain"
        case .portugal:
            return "Portugal"
        case .unitedKingdom:
            return "UK"
        }
    }
}
