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

#if canImport(UIKit)
public struct EditorScrollDisable: EnvironmentKey {
    public static let defaultValue = false
}
#endif

#if canImport(UIKit) && !os(visionOS)
public struct EditorInputAccessoryViewKey: EnvironmentKey {
    public static let defaultValue: UIView? = nil
}
#endif

public struct EditorCSSKey: EnvironmentKey {
    public static let defaultValue: String? = nil
}

public struct OnEditorLoadedKey: EnvironmentKey {
    public static let defaultValue: (() -> Void)? = nil
}

public struct OnCaretPositionChangeKey: EnvironmentKey {
    public static let defaultValue: ((CGRect) -> Void)? = nil
}

public struct OnJavaScriptFunctionFailKey: EnvironmentKey {
    public static let defaultValue: ((any Error, String) -> Void)? = nil
}

public struct IntrospectEditorKey: EnvironmentKey {
    public static let defaultValue: ((RichHTMLEditorView) -> Void)? = nil
}

// MARK: - Environment Values

public extension EnvironmentValues {
    #if canImport(UIKit)
    var editorScrollable: Bool {
        get { self[EditorScrollDisable.self] }
        set { self[EditorScrollDisable.self] = newValue }
    }
    #endif

    #if canImport(UIKit) && !os(visionOS)
    var editorInputAccessoryView: UIView? {
        get { self[EditorInputAccessoryViewKey.self] }
        set { self[EditorInputAccessoryViewKey.self] = newValue }
    }
    #endif

    var editorCSS: String? {
        get { self[EditorCSSKey.self] }
        set { self[EditorCSSKey.self] = newValue }
    }

    var onEditorLoaded: (() -> Void)? {
        get { self[OnEditorLoadedKey.self] }
        set { self[OnEditorLoadedKey.self] = newValue }
    }

    var onCaretPositionChange: ((CGRect) -> Void)? {
        get { self[OnCaretPositionChangeKey.self] }
        set { self[OnCaretPositionChangeKey.self] = newValue }
    }

    var onJavaScriptFunctionFail: ((any Error, String) -> Void)? {
        get { self[OnJavaScriptFunctionFailKey.self] }
        set { self[OnJavaScriptFunctionFailKey.self] = newValue }
    }

    var introspectEditor: ((RichHTMLEditorView) -> Void)? {
        get { self[IntrospectEditorKey.self] }
        set { self[IntrospectEditorKey.self] = newValue }
    }
}
