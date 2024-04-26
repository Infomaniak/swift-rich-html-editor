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
public protocol RichEditorViewDelegate: AnyObject {
    /// Tells the delegate when the specified editor view is fully loaded and ready to be used.
    func richEditorViewDidLoad(_ richEditorView: RichEditorView)

    /// Tells the delegate when the user changes the content or format in the specified editor view.
    func richEditorViewDidChange(_ richEditorView: RichEditorView)

    ///
    func richEditorViewDidChangeSelection(_ richEditorView: RichEditorView)

    /// Tells the delegate when the height of the content of the specified editor changes.
    func richEditorView(_ richEditorView: RichEditorView, contentHeightDidChange contentHeight: CGFloat)

    /// Tells the delegate when the attributes of the selected text changes in the specified editor view.
    func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: RETextAttributes)
}

// Default implementation for optional functions
public extension RichEditorViewDelegate {
    func richEditorViewDidLoad(_ richEditorView: RichEditorView) {}
    func richEditorViewDidChange(_ richEditorView: RichEditorView) {}
    func richEditorViewDidChangeSelection(_ richEditorView: RichEditorView) {}
    func richEditorView(_ richEditorView: RichEditorView, contentHeightDidChange contentHeight: CGFloat) {}
    func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: RETextAttributes) {}
}
