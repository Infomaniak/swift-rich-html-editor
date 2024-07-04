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

public struct IsEditorScrollableKey: EnvironmentKey {
    public static var defaultValue = false
}

public struct EditorInputAccessoryViewKey: EnvironmentKey {
    public static var defaultValue: UIView?
}

public struct OnCursorPositionChangeKey: EnvironmentKey {
    public static var defaultValue: ((CGRect) -> Void)?
}

public struct OnTextAttributesChangeKey: EnvironmentKey {
    public static var defaultValue: ((TextAttributes) -> Void)?
}

// MARK: - Environment Values

public extension EnvironmentValues {
    var isEditorScrollable: Bool {
        get { self[IsEditorScrollableKey.self] }
        set { self[IsEditorScrollableKey.self] = newValue }
    }

    var editorInputAccessoryView: UIView? {
        get { self[EditorInputAccessoryViewKey.self] }
        set { self[EditorInputAccessoryViewKey.self] = newValue }
    }

    var onCursorPositionChange: ((CGRect) -> Void)? {
        get { self[OnCursorPositionChangeKey.self] }
        set { self[OnCursorPositionChangeKey.self] = newValue }
    }

    var onTextAttributesChange: ((TextAttributes) -> Void)? {
        get { self[OnTextAttributesChangeKey.self] }
        set { self[OnTextAttributesChangeKey.self] = newValue }
    }
}

// MARK:  - Modifiers

public extension View {
    func isEditorScrollable(_ value: Bool) -> some View {
        environment(\.isEditorScrollable, value)
    }

    func editorInputAccessoryView(_ value: UIView?) -> some View {
        environment(\.editorInputAccessoryView, value)
    }

    func onCursorPositionChange(perform action: @escaping (CGRect) -> Void) -> some View {
        environment(\.onCursorPositionChange, action)
    }

    func onTextAttributesChange(perform action: @escaping (TextAttributes) -> Void) -> some View {
        environment(\.onTextAttributesChange, action)
    }
}
