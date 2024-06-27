//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

#if canImport(UIKit)
import UIKit

public typealias PlatformView = UIView
public typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit

public typealias PlatformView = NSView
public typealias PlatformColor = NSColor
#endif

import OSLog
import WebKit

public class RichEditorView: PlatformView {
    // MARK: - Public Properties

    /// The HTML that the editor view displays.
    public var html: String {
        get {
            return internalHTMLContent
        }
        set {
            setHTMLContent(newValue)
        }
    }

    #if os(iOS)
    /// The custom accessory view to display when the editor view becomes the first responder.
    override public var inputAccessoryView: UIView? {
        get {
            return webView.richEditorInputAccessoryView
        }
        set {
            webView.richEditorInputAccessoryView = newValue
        }
    }
    #endif

    #if canImport(UIKit)
    /// A Boolean value that indicates whether the responder accepts first responder status.
    override public var canBecomeFirstResponder: Bool {
        return true
    }

    #elseif canImport(AppKit)
    /// A Boolean value that indicates whether the responder accepts first responder status.
    override public var acceptsFirstResponder: Bool {
        return true
    }
    #endif

    #if canImport(UIKit)
    /// Returns a Boolean value indicating whether this object is the first responder.
    override public var isFirstResponder: Bool {
        return webView.containsFirstResponder
    }
    #endif

    /// A Boolean value that indicates whether the DOM of the underlying WKWebView is loaded.
    public var isEditorLoaded: Bool {
        return javaScriptManager.isDOMContentLoaded
    }

    /// The object you use to react to editor's events.
    public weak var delegate: RichEditorViewDelegate?

    /// The content height of the editor view.
    public private(set) var contentHeight = CGFloat.zero

    /// The style of the text currently selected in the editor view.
    public private(set) var selectedTextAttributes = TextAttributes()

    /// The web view that displays the HTML and handle the input.
    public private(set) var webView: WKWebView!

    // MARK: - Private properties

    var internalHTMLContent = ""

    var javaScriptManager: JavaScriptManager!
    var scriptMessageHandler: ScriptMessageHandler!

    let logger = Logger(subsystem: Constants.packageID, category: "ScriptMessageHandler")

    override init(frame: CGRect) {
        super.init(frame: frame)

        scriptMessageHandler = ScriptMessageHandler()
        scriptMessageHandler.delegate = self

        setUpWebView()
        javaScriptManager = JavaScriptManager(webView: webView)
        javaScriptManager.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Notifies the receiver that it’s about to become first responder in its window.
    override public func becomeFirstResponder() -> Bool {
        javaScriptManager.focus()
        return true
    }

    /// Notifies this object that it has been asked to relinquish its status as first responder in its window.
    override public func resignFirstResponder() -> Bool {
        javaScriptManager.blur()
        return true
    }
}

// MARK: - Customize Editor

public extension RichEditorView {
    /// Injects CSS code to customize the appearance of the editor view.
    /// - Parameter css: CSS code.
    func injectAdditionalCSS(_ css: String) {
        javaScriptManager.injectCSS(css)
    }
}

// MARK: - WKWebView

public extension RichEditorView {
    private func setUpWebView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        #if os(iOS)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.delegate = self
        #endif
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
        if #available(iOS 14.0, macOS 11.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = false
        } else {
            webView.configuration.preferences.javaScriptEnabled = false
        }

        for scriptMessage in ScriptMessageHandler.ScriptMessage.allCases {
            webView.configuration.userContentController.add(scriptMessageHandler, scriptMessage: scriptMessage)
        }
    }

    private func loadScripts() {
        for script in UserScript.allCases {
            do {
                try script.load(to: webView)
            } catch {
                logger.error("Error while loading UserScript: \(error)")
            }
        }
    }

    private func loadWebViewPage() {
        guard let indexURL = Bundle.module.url(forResource: "index", withExtension: "html") else {
            return
        }

        let request = URLRequest(url: indexURL)
        webView.load(request)
    }

    private func enableWebViewDebug() {
        if #available(iOS 16.4, macOS 13.3, *) {
            #if DEBUG
            webView.isInspectable = true
            #endif
        }
    }

    private func setHTMLContent(_ newContent: String) {
        javaScriptManager.setHTMLContent(newContent)
    }
}

// MARK: - UIScrollViewDelegate

#if os(iOS)
extension RichEditorView: UIScrollViewDelegate {
    // The WebView should never scroll.
    //
    // Disabling the scrollview is not enough to completely prevent scrolling.
    // It is necessary to reset the scrollOffset when it changes (when the focus is under the keyboard for example).
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset = .zero
    }
}
#endif

// MARK: - ScriptMessageHandlerDelegate

extension RichEditorView: ScriptMessageHandlerDelegate {
    func editorDidLoad() {
        javaScriptManager.isDOMContentLoaded = true
        delegate?.richEditorViewDidLoad(self)
    }

    func contentDidChange(_ text: String) {
        internalHTMLContent = text
        delegate?.richEditorViewDidChange(self)
    }

    func contentHeightDidChange(_ contentHeight: CGFloat) {
        self.contentHeight = contentHeight
        delegate?.richEditorView(self, contentHeightDidChange: contentHeight)
    }

    func selectedTextAttributesDidChange(_ selectedTextAttributes: TextAttributes?) {
        guard let selectedTextAttributes else {
            return
        }

        self.selectedTextAttributes = selectedTextAttributes
        delegate?.richEditorView(self, selectedTextAttributesDidChange: selectedTextAttributes)
    }

    func caretRectDidChange(_ position: CGRect) {
        delegate?.richEditorView(self, cursorPositionDidChange: position)
    }

    func cursorPositionDidChange(_ cursorRect: CGRect) {
        delegate?.richEditorView(self, cursorPositionDidChange: cursorRect)
    }
}

// MARK: - JavaScriptManagerDelegate

extension RichEditorView: JavaScriptManagerDelegate {
    func javascriptFunctionDidFail(error: any Error) {
        delegate?.richEditorView(self, javascriptFunctionDidFail: error)
    }
}
