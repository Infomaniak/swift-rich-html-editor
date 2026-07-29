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

public class RichHTMLWebView: WKWebView {
    #if canImport(UIKit) && !os(visionOS)
    public override var inputAccessoryView: UIView? {
        get {
            return richHTMLEditorInputAccessoryView
        }
        set {
            richHTMLEditorInputAccessoryView = newValue
        }
    }

    private var richHTMLEditorInputAccessoryView: UIView?
    #endif
    
    override public func buildMenu(with builder: UIMenuBuilder) {
           super.buildMenu(with: builder)

           guard builder.system == .context else {
               return
           }

           let command = UICommand(
               title: "Coucou Valentin et Elena",
               action: #selector(pasteWithoutStyling)
           )

           builder.insertChild(
               UIMenu(options: .displayInline, children: [command]),
               atStartOfMenu: .standardEdit
           )
       }

       @objc
       private func pasteWithoutStyling(_ sender: Any?) {
           pasteAndMatchStyle(sender)
       }

       override public func canPerformAction(
           _ action: Selector,
           withSender sender: Any?
       ) -> Bool {
           if action == #selector(pasteWithoutStyling) {
               return super.canPerformAction(
                   #selector(pasteAndMatchStyle(_:)),
                   withSender: sender
               )
           }

           return super.canPerformAction(action, withSender: sender)
       }
}
