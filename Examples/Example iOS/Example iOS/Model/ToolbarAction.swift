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

import InfomaniakRichEditor
import UIKit

enum ToolbarAction: Int {
    case dismissKeyboard, bold, italic, underline, strikethrough, toggleSubscript, toggleSuperscript, orderedList, unorderedList, removeFormat

    static let actionGroups: [[Self]] = [
        [.dismissKeyboard],
        [.bold, .italic, .underline, .strikethrough],
        [.toggleSubscript, .toggleSuperscript],
        [.orderedList, .unorderedList],
        [.removeFormat]
    ]

    var icon: UIImage? {
        let systemName = switch self {
        case .dismissKeyboard:
            "keyboard.chevron.compact.down"
        case .bold:
            "bold"
        case .italic:
            "italic"
        case .underline:
            "underline"
        case .strikethrough:
            "strikethrough"
        case .toggleSubscript:
            "textformat.subscript"
        case .toggleSuperscript:
            "textformat.superscript"
        case .orderedList:
            "list.number"
        case .unorderedList:
            "list.star"
        case .removeFormat:
            "xmark.circle"
        }

        return UIImage(systemName: systemName)
    }

    func isSelected(_ textAttributes: TextAttributes) -> Bool {
        switch self {
        case .bold:
            return textAttributes.hasBold
        case .italic:
            return textAttributes.hasItalic
        case .underline:
            return textAttributes.hasUnderline
        case .strikethrough:
            return textAttributes.hasStrikeThrough
        case .toggleSubscript:
            return textAttributes.hasSubscript
        case .toggleSuperscript:
            return textAttributes.hasSuperscript
        case .orderedList:
            return textAttributes.hasOrderedList
        case .unorderedList:
            return textAttributes.hasUnorderedList
        case .dismissKeyboard, .removeFormat:
            return false
        }
    }
}
