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

extension WKUserContentController {
    func add(_ scriptMessageHandler: any WKScriptMessageHandler, scriptMessage: ScriptMessageHandler.ScriptMessage) {
        add(scriptMessageHandler, name: scriptMessage.rawValue)
    }

    func addUserScript(named filename: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool) throws {
        guard let url = Bundle.module.url(forResource: filename, withExtension: "js"), let document = try? String(contentsOf: url)
        else { throw EditorError.impossibleToLoadWKUserScript(filename: filename) }

        addUserScript(WKUserScript(source: document, injectionTime: injectionTime, forMainFrameOnly: true))
    }
}
