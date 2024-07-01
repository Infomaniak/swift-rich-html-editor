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

// MARK: - Set up toolbar

extension ViewController {
    func setUpToolbar() {
        let toolbarView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 56))
        toolbarView.backgroundColor = .systemGray6

        let scrollView = setUpScrollView(to: toolbarView)
        setUpAllButtons()
        setUpStackView(to: scrollView)

        editor.inputAccessoryView = toolbarView
    }

    private func setUpScrollView(to view: UIView) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = true
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return scrollView
    }

    private func setUpStackView(to scrollView: UIScrollView) {
        let stackView = UIStackView(arrangedSubviews: toolbarButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            scrollView.frameLayoutGuide.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
    }

    private func setUpAllButtons() {
        for group in ToolbarAction.actionGroups {
            for action in group {
                let button = setUpButton(action: action)
                button.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
                toolbarButtons.append(button)
            }

            if group != ToolbarAction.actionGroups.last {
                let divider = setUpDivider()
                toolbarButtons.append(divider)
            }
        }
    }

    private func setUpButton(action: ToolbarAction) -> UIButton {
        let button = UIButton(configuration: .borderedTinted())
        button.setImage(action.icon, for: .normal)
        button.tag = action.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
        return button
    }

    private func setUpDivider() -> UIDivider {
        let divider = UIDivider()
        divider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 30)
        ])
        return divider
    }
}

// MARK: - Handle toolbar buttons

extension ViewController {
    @objc func didTapToolbarButton(_ sender: UIButton) {
        guard let action = ToolbarAction(rawValue: sender.tag) else {
            return
        }

        switch action {
        case .dismissKeyboard:
            _ = editor.resignFirstResponder()
        case .bold:
            editor.bold()
        case .italic:
            editor.italic()
        case .underline:
            editor.underline()
        case .strikethrough:
            editor.strikethrough()
        case .toggleSubscript:
            editor.toggleSubscript()
        case .toggleSuperscript:
            editor.toggleSuperscript()
        case .orderedList:
            editor.orderedList()
        case .unorderedList:
            editor.unorderedList()
        case .justifyFull:
            editor.justify(.full)
        case .justifyLeft:
            editor.justify(.left)
        case .justifyCenter:
            editor.justify(.center)
        case .justifyRight:
            editor.justify(.right)
        case .fontName:
            presentFontNameAlert()
        case .fontSize:
            presentFontSizeAlert()
        case .outdent:
            editor.outdent()
        case .indent:
            editor.indent()
        case .undo:
            editor.undo()
        case .redo:
            editor.redo()
        case .removeFormat:
            editor.removeFormat()
        }
    }

    private func presentFontNameAlert() {
        let alertViewController = UIAlertController(title: "Choose Font", message: nil, preferredStyle: .actionSheet)

        let fontOptions = ["-apple-system", "serif", "sans-serif", "Savoye Let"]
        for fontOption in fontOptions {
            alertViewController.addAction(UIAlertAction(title: fontOption, style: .default) { _ in
                self.editor.setFontName(fontOption)
            })
        }
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertViewController, animated: true)
    }

    private func presentFontSizeAlert() {
        let alertViewController = UIAlertController(
            title: "Choose Font Size",
            message: "Choose a font size between 1 and 7",
            preferredStyle: .alert
        )

        alertViewController.addTextField { textField in
            textField.keyboardType = .numberPad
            if let fontSize = self.editor.selectedTextAttributes.fontSize {
                textField.text = "\(fontSize)"
            }
        }

        alertViewController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alertViewController.textFields?[0].text, let newSize = Int(text) else { return }
            self.editor.setFontSize(newSize)
        })
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertViewController, animated: true)
    }
}
