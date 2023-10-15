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
        NavigationView {
            ZStack {
                VStack {
                    Picker("Universities Of", selection: $selectedCountry) {
                        ForEach(Countries.allCases, id: \.self) { country in
                            Text(country.getCountryName())
                                .font(.title)
                        }
                    }
                    .padding(.horizontal)
                    .pickerStyle(.navigationLink)
                    .onChange(of: selectedCountry) { newValue in
                        self.searchText = ""
                        viewModel.getUniversities(country: newValue)
                    }
                    
                    TextField("Search", text: $searchText)
                        .onChange(of: searchText) { searchText in
                            viewModel.getFilteredUniversities(searchText)
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    List(viewModel.universities, id: \.self) { university in
                        NavigationLink(university.name ?? "", destination: WebView(url: university.webPages?.first))
                            .padding(.vertical, 10)
                            .listRowSeparator(.hidden, edges: .all)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.never)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .padding()
            .edgesIgnoringSafeArea(.bottom)
                
                LoadingView()
                    .opacity(viewModel.isLoading ? 1 : 0)
                    
            }
        }
        .disableAutocorrection(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
