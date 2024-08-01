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

import SwiftUI

#if canImport(UIKit)
public typealias PlateformViewRepresentable = UIViewRepresentable
#elseif canImport(AppKit)
public typealias PlateformViewRepresentable = NSViewRepresentable
#endif

public struct RichHTMLEditor: PlateformViewRepresentable {
    #if canImport(UIKit)
    @Environment(\.editorScrollable) private var isEditorScrollable
    #endif
    #if canImport(UIKit) && !os(visionOS)
    @Environment(\.editorInputAccessoryView) private var editorInputAccessoryView
    #endif

    @Environment(\.editorCSS) var editorCSS
    @Environment(\.onEditorLoaded) var onEditorLoaded
    @Environment(\.onCaretPositionChange) var onCaretPositionChange
    @Environment(\.onJavaScriptFunctionFail) var onJavaScriptFunctionFail
    @Environment(\.introspectEditor) var introspectEditor

    @Binding public var html: String
    @ObservedObject public var textAttributes: TextAttributes

    public init(html: Binding<String>, textAttributes: TextAttributes) {
        _html = html
        _textAttributes = ObservedObject(wrappedValue: textAttributes)
    }

    // MARK: - Platform functions

    private func createPlatformView(context: Context) -> RichHTMLEditorView {
        let richHTMLEditorView = RichHTMLEditorView()
        richHTMLEditorView.delegate = context.coordinator
        richHTMLEditorView.html = html

        if let css = editorCSS {
            richHTMLEditorView.injectAdditionalCSS(css)
        }
        introspectEditor?(richHTMLEditorView)

        textAttributes.editor = richHTMLEditorView

        return richHTMLEditorView
    }

    private func updatePlatformView(_ richHTMLEditorView: RichHTMLEditorView) {
        if richHTMLEditorView.html != html {
            richHTMLEditorView.html = html
        }

        #if canImport(UIKit)
        if richHTMLEditorView.isScrollEnabled != isEditorScrollable {
            richHTMLEditorView.isScrollEnabled = isEditorScrollable
        }
        #endif
        #if canImport(UIKit) && !os(visionOS)
        if richHTMLEditorView.inputAccessoryView != editorInputAccessoryView {
            richHTMLEditorView.inputAccessoryView = editorInputAccessoryView
        }
        #endif
    }

    @available(iOS 16.0, macOS 13.0, *)
    private func sizeThatFits(_ proposal: ProposedViewSize, editor: RichHTMLEditorView, context: Context) -> CGSize? {
        return proposal.replacingUnspecifiedDimensions(by: editor.intrinsicContentSize)
    }

    public func makeCoordinator() -> RichHTMLEditorCoordinator {
        return RichHTMLEditorCoordinator(parent: self)
    }

    // MARK: - UIView

    public func makeUIView(context: Context) -> RichHTMLEditorView {
        return createPlatformView(context: context)
    }

    public func updateUIView(_ richHTMLEditorView: RichHTMLEditorView, context: Context) {
        updatePlatformView(richHTMLEditorView)
    }

    @available(iOS 16.0, macOS 13.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: RichHTMLEditorView, context: Context) -> CGSize? {
        return sizeThatFits(proposal, editor: uiView, context: context)
    }

    // MARK: - NSView

    public func makeNSView(context: Context) -> RichHTMLEditorView {
        return createPlatformView(context: context)
    }

    public func updateNSView(_ richHTMLEditorView: RichHTMLEditorView, context: Context) {
        updatePlatformView(richHTMLEditorView)
    }

    @available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize, nsView: RichHTMLEditorView, context: Context) -> CGSize? {
        return sizeThatFits(proposal, editor: nsView, context: context)
    }
}
