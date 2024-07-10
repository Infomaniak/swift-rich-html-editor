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

public struct RichEditor: PlateformViewRepresentable {
    #if canImport(UIKit)
    @Environment(\.editorScrollable) private var isEditorScrollable
    @Environment(\.editorInputAccessoryView) private var editorInputAccessoryView
    #endif

    @Environment(\.editorCSS) var editorCSS
    @Environment(\.onEditorLoaded) var onEditorLoaded
    @Environment(\.onCursorPositionChange) var onCursorPositionChange
    @Environment(\.onJavaScriptFunctionFail) var onJavaScriptFunctionFail
    @Environment(\.introspectEditor) var introspectEditor

    @Binding public var html: String
    @Binding public var textAttributes: TextAttributes

    public init(html: Binding<String>, textAttributes: Binding<TextAttributes>) {
        _html = html
        _textAttributes = textAttributes
    }

    // MARK: - Platform functions

    private func createPlatformView(context: Context) -> RichEditorView {
        let richEditor = RichEditorView()
        richEditor.delegate = context.coordinator
        richEditor.html = html

        if let css = editorCSS {
            richEditor.injectAdditionalCSS(css)
        }
        introspectEditor?(richEditor)

        return richEditor
    }

    private func updatePlatformView(_ richEditorView: RichEditorView) {
        if richEditorView.html != html {
            richEditorView.html = html
        }

        updateTextAttributes(richEditorView)

        #if canImport(UIKit)
        if richEditorView.isScrollEnabled != isEditorScrollable {
            richEditorView.isScrollEnabled = isEditorScrollable
        }
        if richEditorView.inputAccessoryView != editorInputAccessoryView {
            richEditorView.inputAccessoryView = editorInputAccessoryView
        }
        #endif
    }

    public func makeCoordinator() -> RichEditorCoordinator {
        return RichEditorCoordinator(parent: self)
    }

    // MARK: - UIView

    public func makeUIView(context: Context) -> RichEditorView {
        return createPlatformView(context: context)
    }

    public func updateUIView(_ richEditorView: RichEditorView, context: Context) {
        updatePlatformView(richEditorView)
    }

    // MARK: - NSView

    public func makeNSView(context: Context) -> RichEditorView {
        return createPlatformView(context: context)
    }

    public func updateNSView(_ richEditorView: RichEditorView, context: Context) {
        updatePlatformView(richEditorView)
    }

    // MARK: - Private functions

    private func updateTextAttributes(_ richEditorView: RichEditorView) {
        let uiTextAttributes = richEditorView.selectedTextAttributes

        if textAttributes.bold != uiTextAttributes.hasBold {
            richEditorView.bold()
        }
    }
}
