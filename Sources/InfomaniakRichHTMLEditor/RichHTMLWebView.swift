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
    override public var inputAccessoryView: UIView? {
        get {
            return richHTMLEditorInputAccessoryView
        }
        set {
            richHTMLEditorInputAccessoryView = newValue
        }
    }

    private var richHTMLEditorInputAccessoryView: UIView?
    #endif
    #if canImport(UIKit)
    public var commands: [HTMLEditorCustomAction] = [] {
        didSet {
            UIMenuSystem.context.setNeedsRebuild()
        }
    }

    override public func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)

        guard builder.system == .context, !commands.isEmpty else { return }

        builder.insertChild(
            UIMenu(options: .displayInline, children: commands.map(\.command)),
            atStartOfMenu: .standardEdit
        )
    }

    @objc func performCustomAction(_ sender: Any?) {
        guard let command = sender as? UICommand,
              let id = command.propertyList as? String,
              let customAction = commands.first(where: { $0.id == id }) else { return }
        customAction.action(self)
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(performCustomAction(_:)) {
            return true
        }
        return super.canPerformAction(action, withSender: sender)
    }
    #endif
}
