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

import AppKit

extension NSToolbarItem.Identifier {
    static let bold = NSToolbarItem.Identifier(rawValue: "Bold")
    static let italic = NSToolbarItem.Identifier(rawValue: "Italic")
    static let underline = NSToolbarItem.Identifier(rawValue: "Underline")
}

extension Notification.Name {
    static let didTapToolbar = Notification.Name("didTapToolbar")
}

final class WindowController: NSWindowController {
    @IBOutlet weak var toolbar: NSToolbar!

    override func windowDidLoad() {
        super.windowDidLoad()

        toolbar.allowsUserCustomization = true
        toolbar.autosavesConfiguration = true
        toolbar.displayMode = .iconOnly
    }
}

extension WindowController: NSToolbarDelegate {
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier.bold,
            NSToolbarItem.Identifier.italic,
            NSToolbarItem.Identifier.underline
        ]
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier.bold,
            NSToolbarItem.Identifier.italic,
            NSToolbarItem.Identifier.underline
        ]
    }

    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        switch itemIdentifier {
        case .bold:
            return createToolbarItem(itemIdentifier: itemIdentifier, image: "bold", label: "Bold")
        case .italic:
            return createToolbarItem(itemIdentifier: itemIdentifier, image: "italic", label: "Italic")
        case .underline:
            return createToolbarItem(itemIdentifier: itemIdentifier, image: "underline", label: "Underline")
        default:
            return nil
        }
    }

    private func createToolbarItem(itemIdentifier: NSToolbarItem.Identifier, image: String, label: String) -> NSToolbarItem {
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.isBordered = true

        toolbarItem.image = NSImage(systemSymbolName: image, accessibilityDescription: nil)
        toolbarItem.label = label
        toolbarItem.paletteLabel = label
        toolbarItem.toolTip = label

        toolbarItem.target = self
        toolbarItem.action = #selector(didTapToolbarItem)

        return toolbarItem
    }

    @objc func didTapToolbarItem(sender: NSToolbarItem) {
        NotificationCenter.default.post(name: .didTapToolbar, object: sender.itemIdentifier)
    }
}
