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

import UIKit

class ToolbarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setUpToolbar()
    }
}

// MARK: Set up UI

extension ToolbarViewController {
    private func setUpToolbar() {
        let verticalStack = UIStackView()
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.isLayoutMarginsRelativeArrangement = true
        verticalStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        view.addSubview(verticalStack)

        addHeader(verticalStack)
        addStyleButtons(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.topAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func addHeader(_ stackView: UIStackView) {
        let titleLabel = UILabel()
        titleLabel.text = "Toolbar"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)

        let closeButton = UIButton(type: .close)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let horizontalStackView = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal

        stackView.addArrangedSubview(horizontalStackView)
    }

    private func addStyleButtons(_ stackView: UIStackView) {
        let bold = createStyleButton(image: UIImage(systemName: "bold"), isFirst: true)
        let italic = createStyleButton(image: UIImage(systemName: "italic"))
        let underline = createStyleButton(image: UIImage(systemName: "underline"))
        let strikethrough = createStyleButton(image: UIImage(systemName: "strikethrough"), isLast: true)

        let horizontalStackView = UIStackView(arrangedSubviews: [
            bold, italic, underline, strikethrough
        ])
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 2

        stackView.addArrangedSubview(horizontalStackView)
    }

    private func createStyleButton(image: UIImage?, isFirst: Bool = false, isLast: Bool = false) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.tintColor = .label
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 8

        var maskedCorners: CACornerMask = []
        if isFirst {
            maskedCorners.insert(.layerMinXMinYCorner)
            maskedCorners.insert(.layerMinXMaxYCorner)
        }
        if isLast {
            maskedCorners.insert(.layerMaxXMinYCorner)
            maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        button.layer.maskedCorners = maskedCorners

        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

        return button
    }
}

#Preview {
    ToolbarViewController()
}
