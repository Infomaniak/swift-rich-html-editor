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

import Combine
import InfomaniakRichHTMLEditor
import SwiftUI

final class EditorToolbar: UIView {
    private lazy var boldButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("B", for: .normal)
        button.addTarget(self, action: #selector(toggleBold), for: .touchUpInside)
        return button
    }()

    let textAttributes: TextAttributes

    private var cancellables = Set<AnyCancellable>()

    init(textAttributes: TextAttributes = TextAttributes()) {
        self.textAttributes = textAttributes

        super.init(frame: .zero)

        setupToolbar()
        bindTextAttributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindTextAttributes() {
        textAttributes.$hasBold
            .receive(on: RunLoop.main)
            .sink { [weak self] hasBold in
                self?.boldButton.isSelected = hasBold
            }
            .store(in: &cancellables)
    }

    private func setupToolbar() {
        backgroundColor = .secondarySystemBackground
        addSubview(boldButton)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            boldButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            boldButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            boldButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    @objc private func toggleBold() {
        textAttributes.bold()
    }
}

struct EditorWithToolbar: View {
    @State private var html = "<h1>EditorWithToolbar</h1><p>This editor <strong>has a toolbar</strong>. Focus the editor to reveal it.</p>"
    @StateObject private var textAttributes = TextAttributes()

    var body: some View {
        RichHTMLEditor(html: $html, textAttributes: textAttributes)
            .editorScrollable(true)
            .editorInputAccessoryView(EditorToolbar(textAttributes: textAttributes))
    }
}

#Preview {
    EditorWithToolbar()
}
