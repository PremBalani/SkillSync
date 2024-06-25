//
//  TwitterWebView.swift
//  SkillSync
//
//  Created by Prem Balani on 5/10/24.
//

import SwiftUI
import WebKit

struct TwitterWebView: View {
    var body: some View {
        WebView(url: URL(string: "https://twitter.com/BrawlStars")!)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
#Preview {
    TwitterWebView()
}
