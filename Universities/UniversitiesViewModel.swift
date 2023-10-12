//
//  UniversitiesViewModel.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 13.10.2023.
//

import Foundation

final class UniversitiesViewModel: ObservableObject {
    @Published var universities = [University]()
    
    func getUniversities() {
        let clientModel = ClientModel(urlString: "http://universities.hipolabs.com/search?country=turkey")
        
        Client().request(clientModel: clientModel, expecting: [University].self) { data in
            switch data {
            case .success(let universities):
                print(universities)
                DispatchQueue.main.async {
                    self.universities = universities
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
