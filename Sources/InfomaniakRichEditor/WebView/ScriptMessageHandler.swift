//
//  ScriptMessageHandler.swift
//
//
//  Created by Valentin Perignon on 13.03.2024.
//

import OSLog
import WebKit

protocol ScriptMessageHandlerDelegate: AnyObject {
    func userDidType(_ text: String)
}

final class ScriptMessageHandler: NSObject, WKScriptMessageHandler {
    enum Handler: String, CaseIterable {
        case userDidType
        case log
    }

    weak var delegate: ScriptMessageHandlerDelegate?

    private let logger = Logger(subsystem: "com.infomaniak.swift-rich-editor", category: "ScriptMessageHandler")

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageName = Handler(rawValue: message.name) else {
            return
        }

        switch messageName {
        case .userDidType:
            userDidType(message)
        case .log:
            log(message)
        }
    }

    private func userDidType(_ message: WKScriptMessage) {
        guard let body = message.body as? String else {
            return
        }
        delegate?.userDidType(body)
    }

    private func log(_ message: WKScriptMessage) {
        guard let body = message.body as? String else {
            return
        }
        logger.log(level: .info, "\(body)")
    }
}
