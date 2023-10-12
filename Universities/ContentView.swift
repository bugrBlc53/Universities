//
//  ContentView.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 11.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = UniversitiesViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(viewModel.universities.first?.name ?? "---")
        }
        .onAppear(perform: {
            viewModel.getUniversities()
        })
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
