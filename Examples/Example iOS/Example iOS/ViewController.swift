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

import InfomaniakRichEditor
import UIKit

final class ViewController: UIViewController {
    private lazy var boldButton = createButton(for: "bold", systemImageName: "bold")
    private lazy var italicButton = createButton(for: "italic", systemImageName: "italic")
    private lazy var underlineButton = createButton(for: "underline", systemImageName: "underline")
    private lazy var strikeThroughButton = createButton(for: "strikeThrough", systemImageName: "strikethrough")
    private lazy var orderedListButton = createButton(for: "orderedList", systemImageName: "list.bullet")
    private lazy var unorderedListButton = createButton(for: "unorderedList", systemImageName: "list.number")

    private var editor: RichEditorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Toolbar

        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemGray6
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)

        let buttonsStack = UIStackView(arrangedSubviews: [
            boldButton, italicButton, underlineButton, strikeThroughButton, orderedListButton, unorderedListButton
        ])
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .equalSpacing
        buttonsStack.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        buttonsStack.isLayoutMarginsRelativeArrangement = true
        buttonsStack.backgroundColor = .systemGray6
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStack)

        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: buttonsStack.bottomAnchor)
        ])

        // Editor

        editor = RichEditorView()
        editor.delegate = self
        editor.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editor)

        NSLayoutConstraint.activate([
            editor.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 8),
            editor.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            editor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            editor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else {
            return
        }
        presentAddLinkAlert()
    }

    private func createButton(for actionName: String, systemImageName: String) -> UIButton {
        let button = UIButton(configuration: .tinted())
        button.setImage(UIImage(systemName: systemImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { _ in self.applyFormat(actionName) }), for: .touchUpInside)
        return button
    }

    private func selectButtonIfNecessary(_ button: UIButton, isSelected: Bool) {
        UIView.animate(withDuration: 0.25) {
            button.isSelected = isSelected
        }
    }

    private func presentAddLinkAlert() {
        let alertViewController = UIAlertController(title: "Add Link", message: nil, preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.placeholder = "Enter URL…"
        }
        let submitAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let answer = alertViewController.textFields![0].text, let url = URL(string: answer) {
                self.editor.addLink(text: "My Link", url: url)
            }
        }
        alertViewController.addAction(submitAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertViewController.addAction(cancelAction)

        present(alertViewController, animated: true)
    }

    @objc private func applyFormat(_ format: String) {
        switch format {
        case "bold":
            editor.bold()
        case "italic":
            editor.italic()
        case "underline":
            editor.underline()
        case "strikeThrough":
            editor.strikethrough()
        case "orderedList":
            editor.orderedList()
        case "unorderedList":
            editor.unorderedList()
        default:
            break
        }
    }
}

// MARK: - RichEditorViewDelegate

extension ViewController: RichEditorViewDelegate {
    func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: RETextAttributes) {
        let selectedFormat = textAttributes.format
        selectButtonIfNecessary(boldButton, isSelected: selectedFormat.hasBold)
        selectButtonIfNecessary(italicButton, isSelected: selectedFormat.hasItalic)
        selectButtonIfNecessary(underlineButton, isSelected: selectedFormat.hasUnderline)
        selectButtonIfNecessary(strikeThroughButton, isSelected: selectedFormat.hasStrikeThrough)
        selectButtonIfNecessary(orderedListButton, isSelected: selectedFormat.hasOrderedList)
        selectButtonIfNecessary(unorderedListButton, isSelected: selectedFormat.hasUnorderedList)
    }
}
