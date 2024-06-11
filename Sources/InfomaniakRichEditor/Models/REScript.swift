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

struct REScript {
    let name: String
    let injectionTime: WKUserScriptInjectionTime

    static let allCases = [
        // Utils
        REScript(name: "captureLog", injectionTime: .atDocumentStart),
        REScript(name: "javascriptBridge", injectionTime: .atDocumentStart),
        REScript(name: "utils", injectionTime: .atDocumentStart),

        // Editor
        REScript(name: "text-attributes", injectionTime: .atDocumentStart),
        REScript(name: "commands", injectionTime: .atDocumentStart),
        REScript(name: "selection", injectionTime: .atDocumentStart),
        REScript(name: "links", injectionTime: .atDocumentStart),
        REScript(name: "observer", injectionTime: .atDocumentStart),

        // Main
        REScript(name: "main", injectionTime: .atDocumentStart)
    ]
}
