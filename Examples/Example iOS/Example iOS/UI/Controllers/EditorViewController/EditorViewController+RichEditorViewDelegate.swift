//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY∆
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

import InfomaniakRichHTMLEditor
import UIKit

extension EditorViewController: RichHTMLEditorViewDelegate {
    func richHTMLEditorViewDidLoad(_ richHTMLEditorView: RichHTMLEditorView) {
        _ = richHTMLEditorView.becomeFirstResponder()
    }

    func richHTMLEditorView(
        _ richHTMLEditorView: RichHTMLEditorView,
        selectedTextAttributesDidChange textAttributes: UITextAttributes
    ) {
        for element in toolbarButtons {
            guard let button = element as? UIButton, let action = ToolbarAction(rawValue: button.tag) else {
                continue
            }
            button.isSelected = action.isSelected(textAttributes)
        }
    }
}
