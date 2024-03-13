//
//  RichEditorView.swift
//
//
//  Created by Valentin Perignon on 29.02.2024.
//

import UIKit
import WebKit

public final class RichEditorView: UIView {
    public var text: String {
        get {
            return htmlContent
        }
        set {
            // TODO: Set HTML content here
        }
    }

    public weak var delegate: RichEditorViewDelegate?

    private var htmlContent = ""

    private var webView: WKWebView!
    private var webViewBridge: WebViewBridge!
    private var scriptMessageHandler: ScriptMessageHandler!

    override init(frame: CGRect) {
        super.init(frame: frame)

        scriptMessageHandler = ScriptMessageHandler()
        scriptMessageHandler.delegate = self

        setUpWebView()
        webViewBridge = WebViewBridge(webView: webView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - WKWebView

public extension RichEditorView {
    func setURLSchemeHandler(_ urlSchemeHandler: (any WKURLSchemeHandler)?, forURLScheme urlScheme: String) {
        webView.configuration.setURLSchemeHandler(urlSchemeHandler, forURLScheme: urlScheme)
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

        configureWebView()
        enableWebViewDebug()

        loadWebViewPage()
        loadScripts()
    }

    private func configureWebView() {
        if #available(iOS 14.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = false
        } else {
            webView.configuration.preferences.javaScriptEnabled = false
        }

        webView.configuration.userContentController.add(scriptMessageHandler, scriptMessage: .userDidType)
    }

    private func loadScripts() {
        webView.configuration.userContentController.addUserScript(
            named: "javascriptBridge",
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        webView.configuration.userContentController.addUserScript(
            named: "editor",
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
    }

    private func loadWebViewPage() {
        guard let indexURL = Bundle.module.url(forResource: "index", withExtension: "html") else {
            return
        }

        let request = URLRequest(url: indexURL)
        webView.load(request)
    }

    private func enableWebViewDebug() {
        if #available(iOS 16.4, *) {
            #if DEBUG
            webView.isInspectable = true
            #endif
        }
    }
}

// MARK: - ScriptMessageHandlerDelegate

extension RichEditorView: ScriptMessageHandlerDelegate {
    func userDidType(_ text: String) {
        htmlContent = text
        delegate?.textViewDidChange(self)
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
    RichEditorView()
}
