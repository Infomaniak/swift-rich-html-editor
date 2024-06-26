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

enum ExecCommand: String {
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
    case fontName
    case fontSize
    case undo
    case redo
    case backgroundColor = "backColor"
    case foregroundColor = "foreColor"
    case createLink

    var type: ExecCommandType? {
        switch self {
        // List of commands that return a boolean state
        case .bold, .italic, .underline, .strikeThrough, .toggleSubscript, .toggleSuperscript, .orderedList, .unorderedList,
             .indent, .outdent:
            return .state
        // List of command that return a value
        case .fontName, .fontSize, .backgroundColor, .foregroundColor:
            return .value
        // List of command that return a custom value
        case .createLink, .justifyFull, .justifyLeft, .justifyCenter, .justifyRight:
            return .custom
        // List of command that return nothing
        case .removeFormat, .undo, .redo:
            return nil
        }
    }
}

enum ExecCommandType {
    case state, value, custom
}

public enum RECommandJustifySide {
    case full
    case left
    case center
    case right

    var command: ExecCommand {
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
