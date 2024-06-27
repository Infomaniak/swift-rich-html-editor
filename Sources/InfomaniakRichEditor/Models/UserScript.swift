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

import WebKit

struct UserScript {
    let name: String
    let injectionTime: WKUserScriptInjectionTime
    var arguments = [String: String]()

    func load(to webView: WKWebView) throws {
        try webView.configuration.userContentController.addUserScript(
            named: name,
            injectionTime: injectionTime,
            forMainFrameOnly: true,
            withArguments: arguments
        )
    }
}

extension UserScript {
    static let allCases = [
        // Utils
        UserScript(name: "captureLog", injectionTime: .atDocumentStart),
        UserScript(name: "javascriptBridge", injectionTime: .atDocumentStart),
        UserScript(name: "utils", injectionTime: .atDocumentStart),

        // Editor
        UserScript(
            name: "text-attributes",
            injectionTime: .atDocumentStart,
            arguments: [
                "STATE_COMMANDS": "",
                "VALUE_COMMANDS": "",
                "CUSTOM_COMMANDS": ""
            ]
        ),
        UserScript(name: "commands", injectionTime: .atDocumentStart),
        UserScript(name: "selection", injectionTime: .atDocumentStart),
        UserScript(name: "links", injectionTime: .atDocumentStart),
        UserScript(name: "observer", injectionTime: .atDocumentStart),

        // Main
        UserScript(name: "main", injectionTime: .atDocumentStart)
    ]
}
