//
//  WKUserContentController+Extension.swift
//  
//
//  Created by Valentin Perignon on 13.03.2024.
//

import Foundation
import WebKit

extension WKUserContentController {
    func add(_ scriptMessageHandler: any WKScriptMessageHandler, scriptMessage: ScriptMessageHandler.ScriptMessage) {
        add(scriptMessageHandler, name: scriptMessage.rawValue)
    }
    
    func addUserScript(named filename: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool) {
        guard let url = Bundle.module.url(forResource: filename, withExtension: "js"),
              let document = try? String(contentsOf: url)
        else { return }

        addUserScript(WKUserScript(source: document, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly))
    }
}
