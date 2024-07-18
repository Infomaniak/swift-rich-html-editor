//  Licensed under the Apache License, Version 2.0 (the "License")
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

/// This object contains the current state of the text selected or at the insertion point.
///
/// The properties are read-only and are automatically updated by the editor.
/// If you want to update the style, you should use the available functions.
public final class TextAttributes: ObservableObject {
    @Published public private(set) var hasBold = false
    @Published public private(set) var hasItalic = false
    @Published public private(set) var hasUnderline = false
    @Published public private(set) var hasStrikethrough = false
    @Published public private(set) var hasSubscript = false
    @Published public private(set) var hasSuperscript = false
    @Published public private(set) var hasOrderedList = false
    @Published public private(set) var hasUnorderedList = false

    @Published public private(set) var hasLink = false
    @Published public private(set) var textJustification: TextJustification?

    @Published public private(set) var fontName = ""
    @Published public private(set) var fontSize: Int?

    @Published public private(set) var foregroundColor: Color?
    @Published public private(set) var backgroundColor: Color?

    weak var editor: RichHTMLEditorView?

    public init() {}

    func update(from uiTextAttributes: UITextAttributes) {
        hasBold = uiTextAttributes.hasBold
        hasItalic = uiTextAttributes.hasItalic
        hasUnderline = uiTextAttributes.hasUnderline
        hasStrikethrough = uiTextAttributes.hasStrikeThrough
        hasSubscript = uiTextAttributes.hasSubscript
        hasSuperscript = uiTextAttributes.hasSuperscript
        hasOrderedList = uiTextAttributes.hasLink
        hasUnorderedList = uiTextAttributes.hasUnorderedList

        hasLink = uiTextAttributes.hasLink
        textJustification = uiTextAttributes.textJustification

        fontName = uiTextAttributes.fontName
        fontSize = uiTextAttributes.fontSize

        if let uiForegroundColor = uiTextAttributes.foregroundColor {
            foregroundColor = Color(uiForegroundColor)
        } else {
            foregroundColor = nil
        }
        if let uiBackgroundColor = uiTextAttributes.backgroundColor {
            backgroundColor = Color(uiBackgroundColor)
        } else {
            backgroundColor = nil
        }
    }
}
