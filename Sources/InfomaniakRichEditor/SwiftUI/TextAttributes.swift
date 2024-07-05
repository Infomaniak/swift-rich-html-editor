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

public class TextAttributes: ObservableObject {
    @Published public var bold = false
    public var italic = false
    public var underline = false
    public var strikethrough = false
    public var hasSubscript = false
    public var hasSuperscript = false
    public var orderedList = false
    public var unorderedList = false

    public var link = false
    public var textJustification: TextJustification?

    public var fontName = ""
    public var fontSize: Int?

    public var foregroundColor: Color?
    public var backgroundColor: Color?

    public init() {}

    func update(from uiTextAttributes: UITextAttributes) {
        bold = uiTextAttributes.hasBold
        italic = uiTextAttributes.hasItalic
        underline = uiTextAttributes.hasUnderline
        strikethrough = uiTextAttributes.hasStrikeThrough
        hasSubscript = uiTextAttributes.hasSubscript
        hasSuperscript = uiTextAttributes.hasSuperscript
        orderedList = uiTextAttributes.hasLink
        unorderedList = uiTextAttributes.hasUnorderedList

        link = uiTextAttributes.hasLink
        textJustification = uiTextAttributes.textJustification

        fontName = uiTextAttributes.fontName
        fontSize = uiTextAttributes.fontSize

        if let uiForegroundColor = uiTextAttributes.foregroundColor {
            foregroundColor = Color(uiForegroundColor)
        }
        if let uiBackgroundColor = uiTextAttributes.backgroundColor {
            backgroundColor = Color(uiBackgroundColor)
        }
    }
}
