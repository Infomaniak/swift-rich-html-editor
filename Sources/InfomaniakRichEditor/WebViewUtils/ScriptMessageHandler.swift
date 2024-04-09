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


import OSLog
import WebKit

protocol ScriptMessageHandlerDelegate: AnyObject {
    func editorDidLoad()
    func contentDidChange(_ text: String)
    func selectionStateDidChange(_ selectedTextAttributes: RETextAttributes?)
}

final class ScriptMessageHandler: NSObject, WKScriptMessageHandler {
    enum Handler: String, CaseIterable {
        case editorDidLoad
        case contentDidChange
        case selectedTextAttributesDidChange
        case scriptLog
    }

    weak var delegate: ScriptMessageHandlerDelegate?

    private let logger = Logger(subsystem: "com.infomaniak.swift-rich-editor", category: "ScriptMessageHandler")

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageName = Handler(rawValue: message.name) else {
            return
        }

        switch messageName {
        case .editorDidLoad:
            editorDidLoad()
        case .contentDidChange:
            contentDidChange(message)
        case .selectedTextAttributesDidChange:
            selectedTextAttributesDidChange(message)
        case .scriptLog:
            scriptLog(message)
        }
    }

    private func editorDidLoad() {
        delegate?.editorDidLoad()
    }

    private func contentDidChange(_ message: WKScriptMessage) {
        guard let body = message.body as? String else {
            return
        }
        delegate?.contentDidChange(body)
    }

    private func selectedTextAttributesDidChange(_ message: WKScriptMessage) {
        guard let body = message.body as? String, let data = body.data(using: .utf8) else {
            return
        }

        do {
            let decoder = JSONDecoder()
            let selectedTextAttributes = try decoder.decode(RETextAttributes.self, from: data)

            delegate?.selectionStateDidChange(selectedTextAttributes)
        } catch {
            logger.error("Error while trying to decode RETextAttributes: \(error)")
            delegate?.selectionStateDidChange(nil)
        }
    }

    private func scriptLog(_ message: WKScriptMessage) {
        guard let body = message.body as? String else {
            return
        }
        logger.info("[ScriptLog] \(body)")
    }
}
