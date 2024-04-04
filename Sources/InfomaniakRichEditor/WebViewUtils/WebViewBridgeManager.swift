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
import WebKit

enum RETextFormat: String {
    case bold
    case italic
    case underline
    case strikeThrough
    case orderedList = "insertOrderedList"
    case unorderedList = "insertUnorderedList"
}

struct WebViewBridgeManager {
    let webView: WKWebView

    private enum JavaScriptFunction {
        case execCommand(command: String, argument: String? = nil)
        case setContent(content: String)

        func call() -> String {
            let formattedArgs = formatArgs(args)
            return "\(identifier)(\(formattedArgs));"
        }

        private var identifier: String {
            switch self {
            case .execCommand(_, _):
                return "execCommand"
            case .setContent:
                return "setContent"
            }
        }

        private var args: [Any?] {
            switch self {
            case .execCommand(let command, let argument):
                return [command, argument]
            case .setContent(let content):
                return [content]
            }
        }

        private func formatArgs(_ args: [Any?]) -> String {
            guard !args.isEmpty else {
                return ""
            }

            let formattedArgs = args.map { arg in
                if let value = arg as? Int {
                    return "\(value)"
                }
                else if let value = arg as? Double {
                    return "\(value)"
                }
                else if let value = arg as? String {
                    return "\"\(value)\""
                }
                else {
                    return "null"
                }
            }

            return formattedArgs.joined(separator: ", ")
        }
    }

    func insertContent(_ content: String) {
        let setContent = JavaScriptFunction.setContent(content: content)
        evaluate(function: setContent)
    }

    func applyFormat(_ format: RETextFormat) {
        let execCommand = JavaScriptFunction.execCommand(command: format.rawValue, argument: nil)
        evaluate(function: execCommand)
    }

    func addLink(path: String) {
        let createLink = JavaScriptFunction.execCommand(command: "createLink", argument: path)
        evaluate(function: createLink)
    }

    private func evaluate(function: JavaScriptFunction) {
        webView.evaluateJavaScript(function.call())
    }

    @MainActor
    private func evaluate(function: JavaScriptFunction) async throws -> Any {
        return try await webView.evaluateJavaScript(function.call())
    }
}
