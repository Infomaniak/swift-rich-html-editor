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

import Foundation

/// The methods for receiving editing-related messages for editor view objects.
///
/// All of the methods in this protocol are optional.
public protocol RichHTMLEditorViewDelegate: AnyObject {
    /// Tells the delegate when the specified editor view is fully loaded and ready to be used.
    ///
    /// The editor must load a ``WebKit/WKWebView`` prior to be editable.
    /// You can inject CSS or set the initial HTML at any time, but the content will
    /// only be visible once the editor is loaded.
    ///
    ///  Implementation of this method is optional.
    ///
    /// - Parameter richHTMLEditorView: The editor which is loaded.
    func richHTMLEditorViewDidLoad(_ richHTMLEditorView: RichHTMLEditorView)

    /// Tells the delegate when the user changes the content or format in the specified editor view.
    ///
    /// The editor calls this method whenever the content of the editor change.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameter richHTMLEditorView: The editor which is loaded.
    func richHTMLEditorViewDidChange(_ richHTMLEditorView: RichHTMLEditorView)

    /// Tells the delegate when the position of the carte or the selection range of the specified
    /// editor moves.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameters:
    ///   - richHTMLEditorView: The editor which is loaded.
    ///   - caretPosition: The new position of the caret or of the selection range.
    func richHTMLEditorView(_ richHTMLEditorView: RichHTMLEditorView, caretPositionDidChange caretPosition: CGRect)

    /// Tells the delegate when the attributes of the selected text changes in the specified editor view.
    ///
    /// When the carte moves, the editor calls this method if the attributes of the selected text is
    /// different from the old one.
    /// For example, the method will be called if the newly selected text is bold but the previous one
    /// was not.
    /// The object ``UITextAttributes`` contains all the information about the selected text.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameters:
    ///   - richHTMLEditorView: The editor which is loaded.
    ///   - textAttributes: The new attributes of the selected text.
    func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        selectedTextAttributesDidChange textAttributes: UITextAttributes
    )

    /// Tells the delegate when a JavaScript function executed in the specified editor has failed.
    ///
    /// When the editor calls a JavaScript to update the content, the CSS, or format the text, an
    /// error may potentially be raised by JavaScript.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameters:
    ///   - richHTMLEditorView: The editor which is loaded.
    ///   - javascriptError: The `Error` containing information about the error raised by JavaScript.
    ///   - function: The name of the failing function.
    func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        javascriptFunctionDidFail javascriptError: any Error,
        whileExecuting function: String
    )
}

// Default implementation for optional functions
public extension RichHTMLEditorViewDelegate {
    func richHTMLEditorViewDidLoad(_ richHTMLEditorView: RichHTMLEditorView) {}
    func richHTMLEditorViewDidChange(_ richHTMLEditorView: RichHTMLEditorView) {}
    func richHTMLEditorView(_ richHTMLEditorView: RichHTMLEditorView, caretPositionDidChange caretPosition: CGRect) {}
    func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        selectedTextAttributesDidChange textAttributes: UITextAttributes
    ) {}
    func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        javascriptFunctionDidFail javascriptError: any Error,
        whileExecuting function: String
    ) {}
}
