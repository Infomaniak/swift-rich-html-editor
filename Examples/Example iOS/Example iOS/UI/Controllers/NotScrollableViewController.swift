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

final class NotScrollableEditorViewController: EditorViewController {
    override func setupEditor() {
        super.setupEditor()

        let scrollView = createScrollView()
        scrollView.addSubview(editor)

        editor.isScrollEnabled = false

        NSLayoutConstraint.activate([
            editor.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            editor.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            editor.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            editor.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            editor.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])

        return scrollView
    }
}
