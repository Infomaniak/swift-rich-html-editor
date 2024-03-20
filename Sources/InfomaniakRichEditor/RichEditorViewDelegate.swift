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


import UIKit

/// The methods for receiving editing-related messages for editor view objects.
public protocol RichEditorViewDelegate: AnyObject {
    /// Tells the delegate when the user changes the content or format in the specified editor view.
    func richEditorViewDidChange(_ richEditorView: RichEditorView)

    /// Tells the delegate when the attributes of the selected text changes in the specified editor view.
    func richEditorView(_ richEditorView: RichEditorView, didSelectedTextAttributesChanged textAttributes: RETextAttributes)
}

// Optional implementation
public extension RichEditorViewDelegate {
    func richEditorViewDidChange(_ richEditorView: RichEditorView) {}
    func richEditorView(_ richEditorView: RichEditorView, didSelectedTextAttributesChanged textAttributes: RETextAttributes) {}
}
