//
//  ContentView.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 11.10.2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = UniversitiesViewModel()
    
    @State var selectedCountry: Countries = .turkiye
    @State var searchText = ""
    
    var body: some View {
        VStack {
            Text("Universities Of \(selectedCountry.getCountryName())")
                .font(.title)
            
            Picker("Please Select A Country", selection: $selectedCountry) {
                ForEach(Countries.allCases, id: \.self) { country in
                    Text(country.getCountryName())
                        .font(.title)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedCountry) { newValue in
                viewModel.getUniversities(country: newValue)
            }
            
            TextField("Search", text: $searchText)
                .onChange(of: searchText) { newValue in
                    viewModel.getFilteredUniversities(newValue)
                }
            
            List(viewModel.universities, id: \.self) { university in
                Text(university.name ?? "")
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
        .onAppear(perform: {
            viewModel.getUniversities(country: selectedCountry)
            print(Countries.allCases.map({ $0.rawValue }))
        })
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
        )
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
