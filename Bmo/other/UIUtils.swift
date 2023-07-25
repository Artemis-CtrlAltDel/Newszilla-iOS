//
//  UIUtils.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 25/7/2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {  }
}

struct AlignHLeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AlignHTrailing: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct AlignVTop: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct AlignVBottom: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct AlignHVTopLeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct AlignHVTopTrailing: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
