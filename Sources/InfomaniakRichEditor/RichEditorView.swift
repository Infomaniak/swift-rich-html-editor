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

    private(set) var webViewBridge: WebViewBridge!

    public override var canBecomeFirstResponder: Bool {
        return true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpWebView()
        webViewBridge = WebViewBridge(webView: webView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Find better solution?
        becomeFirstResponder()
    }

    private func setUpWebView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)

        webView.isUserInteractionEnabled = false

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        loadWebViewResources()
        enableWebViewDebug()
    }

    private func loadWebViewResources() {
        guard let indexURL = Bundle.module.url(forResource: "index", withExtension: "html") else {
            return
        }

        let request = URLRequest(url: indexURL)
        webView.load(request)
    }

    private func enableWebViewDebug() {
        // TODO: Add flag to enable option
        if #available(iOS 16.4, *) {
            #if DEBUG
            webView.isInspectable = true
            #endif
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    RichEditorView()
}
