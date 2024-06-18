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

final class CursorPositionManager {
    var lastCursorPosition: CGRect?

    weak var webView: WKWebView?

    init(webView: WKWebView? = nil) {
        self.webView = webView
    }

    func computePosition(isCollapsed: Bool) -> CGRect? {
        guard let webView, webView.containsFirstResponder else {
            return nil
        }

        let cursorPosition = getCursorPosition(in: webView, isCollapsed: isCollapsed)
        if let cursorPosition {
            lastCursorPosition = cursorPosition
        }

        return cursorPosition
    }
}

#if canImport(UIKit)
extension CursorPositionManager {
    private func getCursorPosition(in webView: WKWebView, isCollapsed: Bool) -> CGRect? {
        if #available(iOS 17.0, *) {
            return getCursorPositionFromV17(in: webView, isCollapsed: isCollapsed)
        } else {
            return getCursorPositionInOlderVersion(in: webView)
        }
    }

    private func getCursorPositionFromV17(in webView: WKWebView, isCollapsed: Bool) -> CGRect? {
        if isCollapsed {
            let standardTextCursorView = webView.findView(withName: "UIStandardTextCursorView")
            return standardTextCursorView?.frame
        } else {
            return nil
        }
    }

    private func getCursorPositionInOlderVersion(in webView: WKWebView) -> CGRect? {
        return nil
    }
}
#elseif canImport(AppKit)
extension CursorPositionHelper {
    private func getCursorPosition(in webView: WKWebView) -> CGRect? {
        return nil
    }
}
#endif
