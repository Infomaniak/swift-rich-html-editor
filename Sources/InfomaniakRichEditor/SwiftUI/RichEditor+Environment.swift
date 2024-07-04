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

// MARK: - Environment Keys

public struct EditorScrollableKey: EnvironmentKey {
    public static var defaultValue = false
}

public struct EditorInputAccessoryViewKey: EnvironmentKey {
    public static var defaultValue: UIView?
}

public struct OnEditorLoadedKey: EnvironmentKey {
    public static var defaultValue: (() -> Void)?
}

public struct OnCursorPositionChangeKey: EnvironmentKey {
    public static var defaultValue: ((CGRect) -> Void)?
}

public struct OnContentHeightChangeKey: EnvironmentKey {
    public static var defaultValue: ((CGFloat) -> Void)?
}

public struct OnTextAttributesChangeKey: EnvironmentKey {
    public static var defaultValue: ((TextAttributes) -> Void)?
}

public struct OnJavaScriptFunctionFailKey: EnvironmentKey {
    public static var defaultValue: (() -> Void)?
}

// MARK: - Environment Values

public extension EnvironmentValues {
    var editorScrollable: Bool {
        get { self[EditorScrollableKey.self] }
        set { self[EditorScrollableKey.self] = newValue }
    }

    var editorInputAccessoryView: UIView? {
        get { self[EditorInputAccessoryViewKey.self] }
        set { self[EditorInputAccessoryViewKey.self] = newValue }
    }

    var onEditorLoaded: (() -> Void)? {
        get { self[OnEditorLoadedKey.self] }
        set { self[OnEditorLoadedKey.self] = newValue }
    }

    var onCursorPositionChange: ((CGRect) -> Void)? {
        get { self[OnCursorPositionChangeKey.self] }
        set { self[OnCursorPositionChangeKey.self] = newValue }
    }

    var onContentHeightChange: ((CGFloat) -> Void)? {
        get { self[OnContentHeightChangeKey.self] }
        set { self[OnContentHeightChangeKey.self] = newValue }
    }

    var onTextAttributesChange: ((TextAttributes) -> Void)? {
        get { self[OnTextAttributesChangeKey.self] }
        set { self[OnTextAttributesChangeKey.self] = newValue }
    }

    var onJavaScriptFunctionFail: (() -> Void)? {
        get { self[OnJavaScriptFunctionFailKey.self] }
        set { self[OnJavaScriptFunctionFailKey.self] = newValue }
    }
}

// MARK:  - Modifiers

public extension View {
    func editorScrollable(_ value: Bool) -> some View {
        environment(\.editorScrollable, value)
    }

    func editorInputAccessoryView(_ value: UIView?) -> some View {
        environment(\.editorInputAccessoryView, value)
    }

    func onEditorLoaded(perform action: @escaping () -> Void) -> some View {
        environment(\.onEditorLoaded, action)
    }

    func onCursorPositionChange(perform action: @escaping (CGRect) -> Void) -> some View {
        environment(\.onCursorPositionChange, action)
    }

    func onContentHeightChange(perform action: @escaping (CGFloat) -> Void) -> some View {
        environment(\.onContentHeightChange, action)
    }

    func onTextAttributesChange(perform action: @escaping (TextAttributes) -> Void) -> some View {
        environment(\.onTextAttributesChange, action)
    }

    func onJavaScriptFunctionFail(perform action: @escaping () -> Void) -> some View {
        environment(\.onJavaScriptFunctionFail, action)
    }
}
