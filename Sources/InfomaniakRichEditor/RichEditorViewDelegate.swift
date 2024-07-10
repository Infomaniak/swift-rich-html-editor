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
public protocol RichEditorViewDelegate: AnyObject {
    /// Tells the delegate when the specified editor view is fully loaded and ready to be used.
    /// 
    /// The editor must load a ``WebKit/WKWebView`` prior to be editable.
    /// You can inject CSS or set the initial HTML at any time, but the content will
    /// only be visible once the editor is loaded.
    /// 
    ///  Implementation of this method is optional.
    /// 
    /// - Parameter richEditorView: The editor which is loaded.
    func richEditorViewDidLoad(_ richEditorView: RichEditorView)

    /// Tells the delegate when the user changes the content or format in the specified editor view.
    ///
    /// The editor calls this method whenever the content of the editor change.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameter richEditorView: The editor which is loaded.
    func richEditorViewDidChange(_ richEditorView: RichEditorView)

    /// Tells the delegate when the position of the cursor or the selection range of the specified
    /// editor moves.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameters:
    ///   - richEditorView: The editor which is loaded.
    ///   - cursorPosition: The new position of the cursor or of the selection range.
    func richEditorView(_ richEditorView: RichEditorView, cursorPositionDidChange cursorPosition: CGRect)

    /// Tells the delegate when the attributes of the selected text changes in the specified editor view.
    ///
    /// When the cursor moves, the editor calls this method if the attributes of the selected text is
    /// different from the old one.
    /// For example, the method will be called if the newly selected text is bold but the previous one
    /// was not.
    /// The object ``UITextAttributes`` contains all the information about the selected text.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameters:
    ///   - richEditorView: The editor which is loaded.
    ///   - textAttributes: The new attributes of the selected text.
    func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: UITextAttributes)

    /// Tells the delegate when a JavaScript function executed in the specified editor has failed.
    ///
    /// When the editor calls a JavaScript to update the content, the CSS, or format the text, an
    /// error may potentially be raised by JavaScript.
    ///
    /// Implementation of this method is optional.
    ///
    /// - Parameters:
    ///   - richEditorView: The editor which is loaded.
    ///   - javascriptError: The `Error` containing information about the error raised by JavaScript.
    func richEditorView(_ richEditorView: RichEditorView, javascriptFunctionDidFail javascriptError: any Error)
}

// Default implementation for optional functions
public extension RichEditorViewDelegate {
    func richEditorViewDidLoad(_ richEditorView: RichEditorView) {}
    func richEditorViewDidChange(_ richEditorView: RichEditorView) {}
    func richEditorView(_ richEditorView: RichEditorView, cursorPositionDidChange cursorPosition: CGRect) {}
    func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: UITextAttributes) {}
    func richEditorView(_ richEditorView: RichEditorView, javascriptFunctionDidFail javascriptError: any Error) {}
}
