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

protocol JavaScriptManagerDelegate: AnyObject {
    func javascriptFunctionDidFail(error: any Error, function: String)
}

final class JavaScriptManager {
    var isDOMContentLoaded = false {
        didSet {
            evaluateWaitingFunctions()
        }
    }

    weak var delegate: JavaScriptManagerDelegate?

    private weak var webView: WKWebView?
    private var functionsWaitingForDOM = [JavaScriptFunction]()

    init(webView: WKWebView) {
        self.webView = webView
    }

    func setHTMLContent(_ content: String) {
        let setContent = JavaScriptFunction.setContent(content: content)
        evaluateWhenDOMIsReady(function: setContent)
    }

    func injectCSS(_ content: String) {
        let injectCSS = JavaScriptFunction.injectCSS(content: content)
        evaluateWhenDOMIsReady(function: injectCSS)
    }

    func execCommand(_ command: ExecCommand, argument: Any? = nil) {
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

    func focus() {
        evaluate(function: .focus)
    }

    func blur() {
        evaluate(function: .blur)
    }

    func setCaretAtBeginningOfDocument() {
        evaluate(function: .setCaretAtEndOfDocument)
    }

    func setCaretAtEndOfDocument() {
        evaluate(function: .setCaretAtEndOfDocument)
    }

    func setCaretAtSelector(selector: String) {
        evaluate(function: .setCaretAtSelector(selector: selector))
    }

    private func evaluateWaitingFunctions() {
        guard isDOMContentLoaded else {
            return
        }

        for function in functionsWaitingForDOM {
            evaluate(function: function)
        }
        functionsWaitingForDOM.removeAll()
    }

    private func evaluateWhenDOMIsReady(function: JavaScriptFunction) {
        guard isDOMContentLoaded else {
            functionsWaitingForDOM.append(function)
            return
        }
        evaluate(function: function)
    }

    private func evaluate(function: JavaScriptFunction) {
        webView?.evaluateJavaScript(function.call()) { [weak self] _, error in
            if let error {
                self?.delegate?.javascriptFunctionDidFail(error: error, function: function.identifier)
            }
        }
    }
}
