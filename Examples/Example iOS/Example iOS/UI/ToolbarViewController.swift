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

final class ToolbarViewController: UIViewController {
    weak var richEditor: RichEditorView!

    var scrollView: UIScrollView!
    var buttons = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6

        setUpScrollView()
        setUpAllButtons()
        setUpStackView()
    }

    private func setUpScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = true
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
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
                button.addTarget(self, action: #selector(didTapToolBarButton), for: .touchUpInside)
                buttons.append(button)
            }

            if group != ToolbarAction.actionGroups.last {
                let divider = setUpDivider()
                buttons.append(divider)
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

extension ToolbarViewController {
    @objc func didTapToolBarButton(_ sender: UIButton) {
        guard let action = ToolbarAction(rawValue: sender.tag) else {
            return
        }

        switch action {
        case .bold:
            richEditor.bold()
        case .italic:
            richEditor.italic()
        case .underline:
            richEditor.underline()
        case .strikethrough:
            richEditor.strikethrough()
        case .toggleSubscript:
            richEditor.toggleSubscript()
        case .toggleSuperscript:
            richEditor.toggleSuperscript()
        case .orderedList:
            richEditor.orderedList()
        case .unorderedList:
            richEditor.unorderedList()
        case .removeFormat:
            richEditor.removeFormat()
        }
    }
}

extension ToolbarViewController: RichEditorViewDelegate {
    func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: TextAttributes) {
        for element in buttons {
            guard let button = element as? UIButton, let action = ToolbarAction(rawValue: button.tag) else {
                continue
            }
            button.isSelected = action.isSelected(textAttributes)
        }
    }
}

#Preview {
    ToolbarViewController()
}
