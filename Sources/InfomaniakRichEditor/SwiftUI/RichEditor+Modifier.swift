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

public extension View {
    #if canImport(UIKit)
    /// Configures whether the editor can use its inner scrollview.
    ///
    /// - Parameter disabled: A Boolean that indicates whether scrolling is disabled.
    ///
    /// - Returns: A view that disables or enables the inner scroll of `RichEditor`
    func editorScrollDisabled(_ disabled: Bool) -> some View {
        environment(\.editorScrollDisabled, disabled)
    }

    /// Appends the specified view as an input accessory view to the editor.
    ///
    /// - Parameter inputAccessoryView: A UIView to use as an input accessory
    ///   view.
    ///
    /// - Returns: A view that uses the specified view as an input accessory view.
    func editorInputAccessoryView(_ inputAccessoryView: UIView) -> some View {
        environment(\.editorInputAccessoryView, inputAccessoryView)
    }
    #endif

    /// Performs an action when the editor is loaded.
    ///
    /// - Parameters:
    ///   - action: A closure to run when the editor is loaded. The closure
    ///     takes a `newValue` parameter that indicates the updated
    ///     value.
    ///
    /// - Returns: A view that fires an action when the editor is loaded.
    func onEditorLoaded(perform action: @escaping () -> Void) -> some View {
        environment(\.onEditorLoaded, action)
    }

    /// Performs an action when the position of the cursor in the editor changes.
    ///
    /// - Parameters:
    ///   - action: A closure to run when the cursor moves. The closure
    ///     takes a `newPosition` parameter that indicates the updated
    ///     position.
    ///
    /// - Returns: A view that fires an action when the position of the cursor changes.
    func onCursorPositionChange(perform action: @escaping (_ newPosition: CGRect) -> Void) -> some View {
        environment(\.onCursorPositionChange, action)
    }

    /// Performs an action when the text attributes for the current selection or at the insertion point change.
    ///
    /// - Parameters:
    ///   - action: A closure to run when the text attributes change. The
    ///     closure takes a `newTextAttributes` parameter that
    ///     indicates the updated text attributes.
    ///
    /// - Returns: A view that fires an action when the text attributes changes.
    func onTextAttributesChange(perform action: @escaping (_ newTextAttributes: UITextAttributes) -> Void) -> some View {
        environment(\.onTextAttributesChange, action)
    }

    /// Performs an action when a JavaScript function executed by the editor fails.
    ///
    /// - Parameters:
    ///   - action: A closure to run when a JavaScript function fails.
    ///
    /// - Returns: A view that fires an action when a JavaScript function fails.
    func onJavaScriptFunctionFail(perform action: @escaping () -> Void) -> some View {
        environment(\.onJavaScriptFunctionFail, action)
    }
}
