//
//  WebViewBridge.swift
//
//
//  Created by Valentin Perignon on 01.03.2024.
//

import Foundation
import WebKit

struct WebViewBridge {
    let webView: WKWebView

    func insert(text: String) {
        execute(function: "document.body.innerHTML += `\(text)`")
    }

    func backspace() {
        execute(function: "document.body.innerHTML = document.body.innerHTML.substring(0, -1)")
    }

    private func execute(function: String) {
        webView.evaluateJavaScript(function)
    }
}
