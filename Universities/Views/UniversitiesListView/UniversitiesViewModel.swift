//
//  UniversitiesViewModel.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 13.10.2023.
//

import Foundation

final class UniversitiesViewModel: ObservableObject {
    var allUniversities: [University] = []
    @Published var universities = [University]()
    @Published var isLoading = false

    init() {
        self.getUniversities(country: .turkiye)
    }
    
    func getUniversities(country: Countries) {
        let clientModel = ClientModel(urlString: "http://universities.hipolabs.com/search?country=\(country.rawValue)")
        isLoading = true
        Client().request(clientModel: clientModel, expecting: [University].self) { data in
            switch data {
            case .success(let universities):
                DispatchQueue.main.async {
                    self.allUniversities = universities
                    self.universities = universities
                    self.isLoading = false
                }
            case .failure(let error):
                print(error)
                self.isLoading = false
            }
        }
    }
    
    func getFilteredUniversities(_ searchText: String) {
        guard !searchText.isEmpty else {
            self.universities = self.allUniversities
            return
        }
        self.universities = self.allUniversities.filter { $0.name?.contains(searchText) ?? false }
    }
}
