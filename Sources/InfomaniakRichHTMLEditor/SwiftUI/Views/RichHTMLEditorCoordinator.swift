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

public final class RichHTMLEditorCoordinator: RichHTMLEditorViewDelegate {
    private let parent: RichHTMLEditor

    init(parent: RichHTMLEditor) {
        self.parent = parent
    }

    public func richHTMLEditorViewDidLoad(_ richHTMLEditorView: RichHTMLEditorView) {
        parent.onEditorLoaded?()
    }

    public func richHTMLEditorViewDidChange(_ richHTMLEditorView: RichHTMLEditorView) {
        if parent.html != richHTMLEditorView.html {
            parent.html = richHTMLEditorView.html
        }
    }

    public func richHTMLEditorView(_ richHTMLEditorView: RichHTMLEditorView, caretPositionDidChange caretPosition: CGRect) {
        parent.onCaretPositionChange?(caretPosition)
    }

    public func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        selectedTextAttributesDidChange textAttributes: UITextAttributes
    ) {
        parent.textAttributes.update(from: textAttributes)
    }

    public func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        javascriptFunctionDidFail javascriptError: any Error,
        whileExecutingFunction function: String
    ) {
        parent.onJavaScriptFunctionFail?(javascriptError, function)
    }
}
