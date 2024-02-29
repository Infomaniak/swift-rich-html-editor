//
//  RichEditorView.swift
//
//
//  Created by Valentin Perignon on 29.02.2024.
//

import UIKit
import WebKit

public final class RichEditorView: UIView {
    private var webView: WKWebView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpWebView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpWebView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        loadWebViewResources()

        // TODO: Remove
        if #available(iOS 16.4, *) {
            #if DEBUG
            webView.isInspectable = true
            #endif
        }
    }

    private func loadWebViewResources() {
        guard let indexURL = Bundle.module.url(forResource: "index", withExtension: "html") else {
            return
        }

        let request = URLRequest(url: indexURL)
        webView.load(request)
    }
}

@available(iOS 17.0, *)
#Preview {
    RichEditorView()
}
