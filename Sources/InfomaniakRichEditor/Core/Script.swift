//
//  Script.swift
//
//
//  Created by Valentin Perignon on 14.03.2024.
//

import WebKit

struct Script {
    let name: String
    let injectionTime: WKUserScriptInjectionTime

    static let allCases = [
        // At document start
        Script(name: "captureLog", injectionTime: .atDocumentStart),
        Script(name: "javascriptBridge", injectionTime: .atDocumentStart),

        // At document end
        Script(name: "editor", injectionTime: .atDocumentEnd)
    ]
}
