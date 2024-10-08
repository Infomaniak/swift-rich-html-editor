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

import Cocoa
import InfomaniakRichHTMLEditor

final class ViewController: NSViewController {
    private var editor: RichHTMLEditorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        editor = RichHTMLEditorView()
        editor.delegate = self
        if let cssURL = Bundle.main.url(forResource: "style", withExtension: "css"),
           let styleCSS = try? String(contentsOf: cssURL) {
            editor.injectAdditionalCSS(styleCSS)
        }
        editor.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editor)

        NSLayoutConstraint.activate([
            editor.topAnchor.constraint(equalTo: view.topAnchor),
            editor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            editor.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        NotificationCenter.default.addObserver(self, selector: #selector(didTapToolbarItem), name: .didTapToolbar, object: nil)
    }

    @objc func didTapToolbarItem(notification: Notification) {
        guard let item = notification.object as? NSToolbarItem.Identifier else {
            return
        }

        switch item {
        case .bold:
            editor.bold()
        case .italic:
            editor.italic()
        case .underline:
            editor.underline()
        case .addLink:
            presentLinkAlert()
        default:
            print("Action not handled.")
        }
    }

    private func presentLinkAlert() {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = "Insert a new link"
        let validateButton = alert.addButton(withTitle: "Validate")
        alert.addButton(withTitle: "Cancel")

        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        alert.accessoryView = textField

        let response = alert.runModal()

        guard response.rawValue == validateButton.tag,
              !textField.stringValue.isEmpty,
              let url = URL(string: textField.stringValue)
        else { return }

        editor.addLink(url: url, text: url.absoluteString)
    }
}

// MARK: - RichHTMLEditorViewDelegate

extension ViewController: RichHTMLEditorViewDelegate {
    func richHTMLEditorView(_ richHTMLEditorView: RichHTMLEditorView, shouldHandleLink link: URL) -> Bool {
        NSWorkspace.shared.open(link)
        return true
    }
}
