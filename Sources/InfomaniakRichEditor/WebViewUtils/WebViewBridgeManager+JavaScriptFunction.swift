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

extension WebViewBridgeManager {
    enum JavaScriptFunction {
        case execCommand(command: String, argument: Any? = nil)
        case setContent(content: String)
        case injectCSS(content: String)
        case createLink(text: String?, url: String)
        case unlink

        func call() -> String {
            let formattedArgs = formatArgs(args)
            return "\(identifier)(\(formattedArgs));"
        }

        private var identifier: String {
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
            case .createLink(let text, let url):
                return [text, url]
            case .unlink:
                return []
            }
        }

        private func formatArgs(_ args: [Any?]) -> String {
            guard !args.isEmpty else {
                return ""
            }

            let formattedArgs = args.map { arg in
                if arg == nil {
                    return "null"
                }
                else if let value = arg as? String {
                    return "\"\(value.escapedForJavaScript)\""
                }
                else if let value = arg as? LosslessStringConvertible {
                    return String(value)
                }
                else {
                    fatalError("Error while encoding \(type(of: arg)) for JavaScript: type not yet implemented.")
                }
            }
            return formattedArgs.joined(separator: ", ")
        }
    }

}
