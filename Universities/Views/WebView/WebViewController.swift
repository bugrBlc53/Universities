//
//  WebView.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 14.10.2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewController : UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
