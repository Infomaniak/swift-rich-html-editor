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

/// An editor to edit HTML content.
///
/// `RichHTMLEditorView` supports the display of HTML content using
/// using custom style and also supports text editing. You typically use an
/// editor to display multiple lines of text, such as when displaying the body
/// of an email.
///
/// The appearance of the editor can be customized thanks to the ``RichHTMLEditorView/injectAdditionalCSS(_:)-406n9`` method.
/// The editor provides information about the style of the currently selected text or of
/// the text at the insertion point in the ``RichHTMLEditorView/selectedTextAttributes``
/// property.
/// Many functions are available to update the style, such as ``RichHTMLEditorView/bold()``.
public class RichHTMLEditorView: PlatformView {
    // MARK: - Public Properties

    /// The HTML code that the editor view contains.
    public var html: String {
        get {
            return rawHTMLContent
        }
        set {
            setHTMLContent(newValue)
        }
    }

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

    #if canImport(UIKit) && !os(visionOS)
    /// The custom accessory view to display when the editor view becomes the first responder.
    override public var inputAccessoryView: UIView? {
        get {
            return webView.richHTMLEditorInputAccessoryView
        }
        set {
            webView.richHTMLEditorInputAccessoryView = newValue
        }
    }
    #endif

    /// The natural size for the receiving view, considering only properties of the view itself.
    override public var intrinsicContentSize: CGSize {
        CGSize(width: PlatformView.noIntrinsicMetric, height: rawContentHeight)
    }

    #if canImport(UIKit)
    /// A Boolean value that indicates whether the editor view use its inner scrollview.
    ///
    /// When the Boolean is `false`, the editor will use the first parent
    /// `UIScrollView` to keep the caret always visible when the
    /// caret moves below the keyboard or off the screen.
    /// However, when the Boolean is `true`, the editor will use the
    /// `UIScrollView` of the inner ``WebKit/WKWebView``
    /// to keep the caret visible.
    ///
    /// The default value is `false`.
    public var isScrollEnabled: Bool {
        get {
            rawIsScrollEnabled
        }
        set {
            setScrollableBehavior(newValue)
        }
    }
    #endif

    /// A Boolean value that indicates whether the DOM of the underlying ``WebKit/WKWebView``
    /// is loaded.
    ///
    /// If an initial content has been set to the editor, it will be displayed once the editor is loaded.
    public var isEditorLoaded: Bool {
        return javaScriptManager.isDOMContentLoaded
    }

    /// The object you use to react to editor's events.
    public weak var delegate: RichHTMLEditorViewDelegate?

    /// The style of the text currently selected in the editor view.
    public private(set) var selectedTextAttributes = UITextAttributes()

    /// The web view that displays the HTML and handle the input.
    public private(set) var webView: WKWebView!

    // MARK: - Private properties

    var rawHTMLContent = ""
    var rawIsScrollEnabled = false
    var rawContentHeight = CGFloat.zero

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

public extension RichHTMLEditorView {
    /// Injects CSS code to customize the appearance of the editor view.
    ///
    /// This method is additive. Each call adds the CSS to the editor and does not replace
    /// previously added code.
    ///
    /// - Parameter css: CSS code to append to the editor.
    func injectAdditionalCSS(_ css: String) {
        javaScriptManager.injectCSS(css)
    }

    /// Injects CSS code to customize the appearance of the editor view.
    ///
    /// This method is additive. Each call adds the CSS to the editor and does not replace
    /// previously added code.
    ///
    /// - Parameter cssURL: URL to the CSS file.
    func injectAdditionalCSS(_ cssURL: URL) {
        guard let css = try? String(contentsOf: cssURL) else { return }
        injectAdditionalCSS(css)
    }
}

// MARK: - WKWebView

public extension RichHTMLEditorView {
    private func setUpWebView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        #if canImport(UIKit)
        webView.scrollView.delegate = self
        #endif
        webView.navigationDelegate = self
        addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        configureWebView()
        enableWebViewDebug()

        #if canImport(UIKit)
        setScrollableBehavior(false)
        #endif

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

        #if canImport(UIKit)
        webView.backgroundColor = .clear
        webView.isOpaque = false
        #endif
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

    #if canImport(UIKit)
    private func setScrollableBehavior(_ isScrollEnabled: Bool) {
        rawIsScrollEnabled = isScrollEnabled
        webView.scrollView.isScrollEnabled = isScrollEnabled
    }
    #endif
}

// MARK: - WKNavigationDelegate

extension RichHTMLEditorView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
        switch navigationAction.navigationType {
        case .linkActivated:
            if let url = navigationAction.request.url, delegate?.richHTMLEditorView(self, shouldHandleLink: url) == true {
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        case .backForward, .formSubmitted, .reload, .formResubmitted:
            decisionHandler(.cancel)
        case .other:
            decisionHandler(.allow)
        @unknown default:
            decisionHandler(.allow)
        }
    }
}

// MARK: - UIScrollViewDelegate

#if canImport(UIKit)
extension RichHTMLEditorView: UIScrollViewDelegate {
    /// When the editor is not scrollable, the WebView should not scroll.
    ///
    /// Disabling the scrollview is not enough to completely prevent
    /// scrolling.
    /// It is necessary to reset the scrollOffset each time it changes
    /// (when the caret is under the keyboard for example).
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isScrollEnabled else { return }
        scrollView.contentOffset = .zero
    }
}
#endif

// MARK: - ScriptMessageHandlerDelegate

extension RichHTMLEditorView: ScriptMessageHandlerDelegate {
    func editorDidLoad() {
        javaScriptManager.isDOMContentLoaded = true
        delegate?.richHTMLEditorViewDidLoad(self)
    }

    func contentDidChange(_ text: String) {
        rawHTMLContent = text
        delegate?.richHTMLEditorViewDidChange(self)
    }

    func contentHeightDidChange(_ contentHeight: CGFloat) {
        rawContentHeight = contentHeight
        invalidateIntrinsicContentSize()
    }

    func selectedTextAttributesDidChange(_ selectedTextAttributes: UITextAttributes?) {
        guard let selectedTextAttributes else {
            return
        }

        self.selectedTextAttributes = selectedTextAttributes
        delegate?.richHTMLEditorView(self, selectedTextAttributesDidChange: selectedTextAttributes)
    }

    func caretRectDidChange(_ position: CGRect) {
        delegate?.richHTMLEditorView(self, caretPositionDidChange: position)
    }

    func caretPositionDidChange(_ caretRect: CGRect) {
        delegate?.richHTMLEditorView(self, caretPositionDidChange: caretRect)

        #if canImport(UIKit)
        if !isScrollEnabled, let scrollView = findClosestScrollView() {
            let scrollRect = convert(caretRect, to: scrollView)
            scrollView.scrollRectToVisible(scrollRect, animated: true)
        }
        #endif
    }
}

// MARK: - JavaScriptManagerDelegate

extension RichHTMLEditorView: JavaScriptManagerDelegate {
    func javascriptFunctionDidFail(error: any Error, function: String) {
        delegate?.richHTMLEditorView(self, javascriptFunctionDidFail: error, whileExecuting: function)
    }
}
