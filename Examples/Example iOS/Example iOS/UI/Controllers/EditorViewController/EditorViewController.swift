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

class EditorViewController: UIViewController {
    var editor: RichHTMLEditorView!
    var toolbarButtons = [UIView]()

    var toolbarCurrentColorPicker: ToolbarAction?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Infomaniak - RichHTMLEditor (iOS)"
        view.backgroundColor = .systemBackground

        setupEditor()
        setupToolbar()
    }

    func setupEditor() {
        createEditor()
    }

    func createEditor() {
        editor = RichHTMLEditorView()
        if let cssURL = Bundle.main.url(forResource: "editor", withExtension: "css"), let css = try? String(contentsOf: cssURL) {
            editor.injectAdditionalCSS(css)
        }
        editor.translatesAutoresizingMaskIntoConstraints = false
        editor.delegate = self
    }
}
