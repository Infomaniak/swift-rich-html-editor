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

enum JavaScriptFunction {
    case execCommand(command: String, argument: Any? = nil)
    case setContent(content: String)
    case injectCSS(content: String)
    case createLink(url: String, text: String?)
    case unlink
    case focus
    case blur
    case setCaretAtBeginningOfDocument
    case setCaretAtEndOfDocument
    case setCaretAtSelector(selector: String)

    var identifier: String {
        switch self {
        case .execCommand:
            return "execCommand"
        case .setContent:
            return "setContent"
        case .injectCSS:
            return "injectCSS"
        case .createLink:
            return "createLink"
        case .unlink:
            return "unlink"
        case .focus:
            return "focus"
        case .blur:
            return "blur"
        case .setCaretAtBeginningOfDocument:
            return "setCaretAtBeginningOfDocument"
        case .setCaretAtEndOfDocument:
            return "setCaretAtEndOfDocument"
        case .setCaretAtSelector:
            return "setCaretAtSelector"
        }
    }

    private var args: [Any?] {
        switch self {
        case .execCommand(let command, let argument):
            return [command, argument]
        case .setContent(let content):
            return [content]
        case .injectCSS(let content):
            return [content]
        case .createLink(let url, let text):
            return [url, text]
        case .setCaretAtSelector(let selector):
            return [selector]
        case .unlink, .focus, .blur, .setCaretAtBeginningOfDocument, .setCaretAtEndOfDocument:
            return []
        }
    }

    func call() -> String {
        let formattedArgs = formatArgs(args)
        return "\(identifier)(\(formattedArgs));"
    }

    private func formatArgs(_ args: [Any?]) -> String {
        guard !args.isEmpty else {
            return ""
        }

        let formattedArgs = args.map { JavaScriptFormatterHelper.format($0) }
        return formattedArgs.joined(separator: ", ")
    }
}
