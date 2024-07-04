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

public struct RichEditor: UIViewRepresentable {
    @Environment(\.isEditorScrollable) private var isEditorScrollable
    @Environment(\.editorInputAccessoryView) private var editorInputAccessoryView

    @Environment(\.onCursorPositionChange) var onCursorPositionChange
    @Environment(\.onTextAttributesChange) var onTextAttributesChange

    @Binding public var html: String

    public init(html: Binding<String>) {
        _html = html
    }

    public func makeUIView(context: Context) -> RichEditorView {
        let richEditor = RichEditorView()
        richEditor.delegate = context.coordinator
        richEditor.html = html

        return richEditor
    }

    public func updateUIView(_ richEditorView: RichEditorView, context: Context) {
        if richEditorView.html != html {
            richEditorView.html = html
        }

        richEditorView.isScrollable = isEditorScrollable
        richEditorView.inputAccessoryView = editorInputAccessoryView
    }

    public func makeCoordinator() -> RichEditorCoordinator {
        return RichEditorCoordinator(parent: self)
    }
}
