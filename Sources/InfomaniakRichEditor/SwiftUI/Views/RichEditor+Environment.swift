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
    public static var defaultValue = false
}

public struct EditorInputAccessoryViewKey: EnvironmentKey {
    public static var defaultValue: UIView?
}
#endif

public struct OnEditorLoadedKey: EnvironmentKey {
    public static var defaultValue: (() -> Void)?
}

public struct OnCursorPositionChangeKey: EnvironmentKey {
    public static var defaultValue: ((CGRect) -> Void)?
}

public struct OnJavaScriptFunctionFailKey: EnvironmentKey {
    public static var defaultValue: (() -> Void)?
}

// MARK: - Environment Values

public extension EnvironmentValues {
    #if canImport(UIKit)
    var editorScrollDisabled: Bool {
        get { self[EditorScrollDisable.self] }
        set { self[EditorScrollDisable.self] = newValue }
    }

    var editorInputAccessoryView: UIView? {
        get { self[EditorInputAccessoryViewKey.self] }
        set { self[EditorInputAccessoryViewKey.self] = newValue }
    }
    #endif

    var onEditorLoaded: (() -> Void)? {
        get { self[OnEditorLoadedKey.self] }
        set { self[OnEditorLoadedKey.self] = newValue }
    }

    var onCursorPositionChange: ((CGRect) -> Void)? {
        get { self[OnCursorPositionChangeKey.self] }
        set { self[OnCursorPositionChangeKey.self] = newValue }
    }

    var onJavaScriptFunctionFail: (() -> Void)? {
        get { self[OnJavaScriptFunctionFailKey.self] }
        set { self[OnJavaScriptFunctionFailKey.self] = newValue }
    }
}
