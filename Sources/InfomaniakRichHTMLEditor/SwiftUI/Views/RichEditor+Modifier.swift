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
    /// - Parameter scrollable: A Boolean that indicates whether scrolling is enabled or not.
    ///
    /// - Returns: A view that disables or enables the inner scroll of the `RichHTMLEditor` view.
    func editorScrollable(_ scrollable: Bool) -> some View {
        environment(\.editorScrollable, scrollable)
    }
    #endif

    #if canImport(UIKit) && !os(visionOS)
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

    func editorCSS(_ css: String) -> some View {
        environment(\.editorCSS, css)
    }

    /// Performs an action when the editor is loaded.
    ///
    /// - Parameter action: A closure to run when the editor is loaded. The closure
    ///   takes a `newValue` parameter that indicates the updated value.
    ///
    /// - Returns: A view that fires an action when the editor is loaded.
    func onEditorLoaded(perform action: @escaping () -> Void) -> some View {
        environment(\.onEditorLoaded, action)
    }

    /// Performs an action when the position of the caret in the editor changes.
    ///
    /// - Parameters action: A closure to run when the caret moves. The closure
    ///   takes a `newPosition` parameter that indicates the updated position.
    ///
    /// - Returns: A view that fires an action when the position of the caret changes.
    func onCaretPositionChange(perform action: @escaping (_ newPosition: CGRect) -> Void) -> some View {
        environment(\.onCaretPositionChange, action)
    }

    /// Performs an action when a JavaScript function executed by the editor fails.
    ///
    /// - Parameter action: A closure to run when a JavaScript function fails.
    ///
    /// - Returns: A view that fires an action when a JavaScript function fails.
    func onJavaScriptFunctionFail(perform action: @escaping (any Error, String) -> Void) -> some View {
        environment(\.onJavaScriptFunctionFail, action)
    }

    /// Performs an action when the editor is initialized, to customize the underlying ``RichHTMLEditorView``.
    ///
    /// - Parameter action: A closure to run when the view is initialized, to customize
    ///   the editor.
    ///
    /// - Returns: A view with the customizations applied to editor.
    func introspectEditor(perform action: @escaping (RichHTMLEditorView) -> Void) -> some View {
        environment(\.introspectEditor, action)
    }
}
