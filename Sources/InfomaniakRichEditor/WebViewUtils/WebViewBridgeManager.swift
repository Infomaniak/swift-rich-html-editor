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

protocol WebViewBridgeManagerDelegate {
    func javascriptFunctionDidFail(error: any Error)
}

struct WebViewBridgeManager {
    let webView: WKWebView
    var delegate: WebViewBridgeManagerDelegate?

    func setHTMLContent(_ content: String) {
        let setContent = JavaScriptFunction.setContent(content: content)
        evaluate(function: setContent)
    }

    func injectCSS(_ content: String) {
        let injectCSS = JavaScriptFunction.injectCSS(content: content)
        evaluate(function: injectCSS)
    }

    func execCommand(_ command: RECommand, argument: Any? = nil) {
        let execCommand = JavaScriptFunction.execCommand(command: command.rawValue, argument: argument)
        evaluate(function: execCommand)
    }

    func addLink(text: String?, path: String) {
        let createLink = JavaScriptFunction.createLink(url: path, text: text)
        evaluate(function: createLink)
    }

    func unlink() {
        evaluate(function: .unlink)
    }

    private func evaluate(function: JavaScriptFunction) {
        webView.evaluateJavaScript(function.call()) { _, error in
            if let error {
                delegate?.javascriptFunctionDidFail(error: error)
            }
        }
    }
}
