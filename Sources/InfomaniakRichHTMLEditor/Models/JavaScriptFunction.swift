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

enum JavaScriptFunction {
    case execCommand(command: String, argument: Sendable? = nil)
    case setContent(content: String)
    case injectCSS(content: String)
    case setSpellcheck(enabled: Bool)
    case setAutocorrect(enabled: Bool)
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
        case .setSpellcheck:
            return "setSpellcheck"
        case .setAutocorrect:
            return "setAutocorrect"
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
        case .setSpellcheck(let enabled):
            return [enabled]
        case .setAutocorrect(let enabled):
            return [enabled]
        case .createLink(let url, let text):
            return [url, text]
        case .setCaretAtSelector(let selector):
            return [selector]
        case .unlink, .focus, .blur, .setCaretAtBeginningOfDocument, .setCaretAtEndOfDocument:
            return []
        }
    }

    var functionBody: String {
        let argumentNames = args.indices.map(argumentName)
        return "\(identifier)(\(argumentNames.joined(separator: ", ")));"
    }

    var arguments: [String: Any] {
        var arguments = [String: Any]()
        for (index, value) in args.enumerated() {
            arguments[argumentName(index)] = value ?? NSNull()
        }
        return arguments
    }

    private func argumentName(_ index: Int) -> String {
        return "arg\(index)"
    }
}
