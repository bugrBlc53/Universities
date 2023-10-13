//
//  WebView.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 14.10.2023.
//

import SwiftUI

struct WebView: View {
    var url: String?
    
    var body: some View {
        WebViewController(request: URLRequest(url: URL(string: url ?? "https://www.apple.com")!))
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(url ?? "")
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.apple.com")
    }
}
