//
//  ScriptMessageHandler.swift
//  
//
//  Created by Valentin Perignon on 13.03.2024.
//

import WebKit

protocol ScriptMessageHandlerDelegate: AnyObject {
    func userDidType(_ text: String)
}

final class ScriptMessageHandler: NSObject, WKScriptMessageHandler {
    enum ScriptMessage: String {
        case userDidType
    }

    weak var delegate: ScriptMessageHandlerDelegate?

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageName = ScriptMessage(rawValue: message.name) else {
            return
        }

        switch messageName {
        case .userDidType:
            userDidType(message)
        }
    }

    private func userDidType(_ message: WKScriptMessage) {
        guard let body = message.body as? String else {
            return
        }
        delegate?.userDidType(body)
    }
}
