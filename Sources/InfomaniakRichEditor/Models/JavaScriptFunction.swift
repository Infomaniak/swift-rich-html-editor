//
//  REJavaScriptFunction.swift
//  InfomaniakRichEditor
//
//  Created by Valentin Perignon on 11.06.2024.
//

import Foundation

enum JavaScriptFunction {
    case execCommand(command: String, argument: Any? = nil)
    case setContent(content: String)
    case injectCSS(content: String)
    case createLink(url: String, text: String?)
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
        case .createLink(let url, let text):
            return [url, text]
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
            } else if let value = arg as? String {
                return "\"\(value.escapedForJavaScript)\""
            } else if let value = arg as? LosslessStringConvertible {
                return String(value)
            } else {
                fatalError("Error while encoding \(type(of: arg)) for JavaScript: type not yet implemented.")
            }
        }
        return formattedArgs.joined(separator: ", ")
    }
}
