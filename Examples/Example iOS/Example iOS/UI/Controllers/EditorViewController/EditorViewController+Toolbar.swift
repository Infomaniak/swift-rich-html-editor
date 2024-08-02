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

import InfomaniakRichHTMLEditor
import UIKit

// MARK: - Set up toolbar

extension EditorViewController {
    func setupToolbar() {
        let toolbarView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 56))
        toolbarView.backgroundColor = .systemGray6

        let scrollView = setupScrollView(to: toolbarView)
        setupAllButtons()
        setupStackView(to: scrollView)

        editor.inputAccessoryView = toolbarView
    }

    private func setupScrollView(to view: UIView) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return scrollView
    }

    private func setupStackView(to scrollView: UIScrollView) {
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

    private func setupAllButtons() {
        for group in ToolbarAction.actionGroups {
            for action in group {
                let button = createButton(action: action)
                button.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
                toolbarButtons.append(button)
            }

            if group != ToolbarAction.actionGroups.last {
                let divider = createDivider()
                toolbarButtons.append(divider)
            }
        }
    }

    private func createButton(action: ToolbarAction) -> UIButton {
        let button = UIButton(configuration: .borderless())
        button.setImage(action.icon, for: .normal)
        button.tag = action.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ])
        return button
    }

    private func createDivider() -> UIDivider {
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

extension EditorViewController {
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
        case .link:
            handleLink()
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
        case .foregroundColor:
            presentColorPicker(title: "Text Color", action: .foregroundColor)
        case .backgroundColor:
            presentColorPicker(title: "Background Color", action: .backgroundColor)
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

    private func handleLink() {
        if editor.selectedTextAttributes.hasLink {
            editor.unlink()
        } else {
            presentCreateLinkAlert()
        }
    }

    private func presentCreateLinkAlert() {
        let alertController = UIAlertController(title: "Create Link", message: nil, preferredStyle: .alert)

        alertController.addTextField { nameTextField in
            nameTextField.placeholder = "Label (Optional)"
        }
        alertController.addTextField { urlTextField in
            urlTextField.placeholder = "URL"
            urlTextField.keyboardType = .URL
        }

        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let rawURL = alertController.textFields?[1].text,
                  let url = URL(string: rawURL)
            else { return }

            self.editor.addLink(url: url, text: alertController.textFields?[0].text)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            _ = self.editor.becomeFirstResponder()
        })

        present(alertController, animated: true)
    }

    private func presentFontNameAlert() {
        let alertController = UIAlertController(title: "Choose Font", message: nil, preferredStyle: .actionSheet)

        let fontOptions = ["-apple-system", "serif", "sans-serif", "Savoye Let"]
        for fontOption in fontOptions {
            alertController.addAction(UIAlertAction(title: fontOption, style: .default) { _ in
                self.editor.setFontName(fontOption)
            })
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }

    private func presentFontSizeAlert() {
        let alertController = UIAlertController(
            title: "Choose Font Size",
            message: "Choose a font size between 1 and 7",
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
            if let fontSize = self.editor.selectedTextAttributes.fontSize {
                textField.text = "\(fontSize)"
            }
        }

        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alertController.textFields?[0].text, let newSize = Int(text) else { return }
            self.editor.setFontSize(newSize)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }

    private func presentColorPicker(title: String, action: ToolbarAction) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = title
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .pageSheet
        colorPicker.popoverPresentationController?.sourceItem = toolbarButtons[action.rawValue]

        toolbarCurrentColorPicker = action

        present(colorPicker, animated: true)
    }
}

// MARK: - UIColorPickerViewControllerDelegate

extension EditorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        guard let toolbarCurrentColorPicker else {
            return
        }

        if toolbarCurrentColorPicker == .foregroundColor {
            editor.setForegroundColor(viewController.selectedColor)
        } else if toolbarCurrentColorPicker == .backgroundColor {
            editor.setBackgroundColor(viewController.selectedColor)
        }
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        toolbarCurrentColorPicker = nil
    }
}
