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

import InfomaniakRichHTMLEditor
import UIKit

enum ToolbarAction: Int {
    case dismissKeyboard, bold, italic, underline, strikethrough, link, toggleSubscript, toggleSuperscript, orderedList,
         unorderedList, justifyFull, justifyLeft, justifyCenter, justifyRight, fontName, fontSize, foregroundColor,
         backgroundColor, outdent, indent, undo, redo, removeFormat

    static let actionGroups: [[Self]] = [
        [.dismissKeyboard],
        [.bold, .italic, .underline, .strikethrough],
        [.link],
        [.toggleSubscript, .toggleSuperscript],
        [.orderedList, .unorderedList],
        [.justifyFull, .justifyLeft, .justifyCenter, .justifyRight],
        [.fontName, .fontSize],
        [.foregroundColor, .backgroundColor],
        [.outdent, .indent],
        [.undo, .redo],
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
        case .link:
            "link"
        case .toggleSubscript:
            "textformat.subscript"
        case .toggleSuperscript:
            "textformat.superscript"
        case .orderedList:
            "list.number"
        case .unorderedList:
            "list.star"
        case .justifyFull:
            "text.justify"
        case .justifyLeft:
            "text.justify.left"
        case .justifyCenter:
            "text.aligncenter"
        case .justifyRight:
            "text.justify.right"
        case .fontName:
            "textformat.alt"
        case .fontSize:
            "textformat.size"
        case .foregroundColor:
            "scribble.variable"
        case .backgroundColor:
            "paintbrush"
        case .outdent:
            "decrease.indent"
        case .indent:
            "increase.indent"
        case .undo:
            "arrow.uturn.backward"
        case .redo:
            "arrow.uturn.forward"
        case .removeFormat:
            "xmark.circle"
        }

        return UIImage(systemName: systemName)
    }

    func isSelected(_ textAttributes: UITextAttributes) -> Bool {
        switch self {
        case .bold:
            return textAttributes.hasBold
        case .italic:
            return textAttributes.hasItalic
        case .underline:
            return textAttributes.hasUnderline
        case .strikethrough:
            return textAttributes.hasStrikeThrough
        case .link:
            return textAttributes.hasLink
        case .toggleSubscript:
            return textAttributes.hasSubscript
        case .toggleSuperscript:
            return textAttributes.hasSuperscript
        case .orderedList:
            return textAttributes.hasOrderedList
        case .unorderedList:
            return textAttributes.hasUnorderedList
        case .justifyFull:
            return textAttributes.textJustification == .full
        case .justifyLeft:
            return textAttributes.textJustification == .left
        case .justifyCenter:
            return textAttributes.textJustification == .center
        case .justifyRight:
            return textAttributes.textJustification == .right
        case .dismissKeyboard, .fontName, .fontSize, .foregroundColor, .backgroundColor, .outdent, .indent, .undo, .redo,
             .removeFormat:
            return false
        }
    }
}
