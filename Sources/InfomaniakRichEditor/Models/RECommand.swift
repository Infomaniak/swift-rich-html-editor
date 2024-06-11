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

import Foundation

enum RECommand: String {
    case removeFormat
    case bold
    case italic
    case underline
    case strikeThrough
    case toggleSubscript = "subscript"
    case toggleSuperscript = "superscript"
    case orderedList = "insertOrderedList"
    case unorderedList = "insertUnorderedList"
    case indent
    case outdent
    case justifyFull
    case justifyLeft
    case justifyCenter
    case justifyRight
    case fontSize
    case increaseFontSize
    case decreaseFontSize
    case undo
    case redo
    case backgroundColor = "backColor"
    case foregroundColor = "hiliteColor"
}

public enum RECommandJustifySide {
    case full
    case left
    case center
    case right

    var command: RECommand {
        switch self {
        case .full:
            return .justifyFull
        case .left:
            return .justifyLeft
        case .center:
            return .justifyCenter
        case .right:
            return .justifyRight
        }
    }
}
