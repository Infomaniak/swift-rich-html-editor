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

import SwiftUI

public class RichEditorCoordinator: RichEditorViewDelegate {
    private let parent: RichEditor

    init(parent: RichEditor) {
        self.parent = parent
    }

    public func richEditorView(_ richEditorView: RichEditorView, cursorPositionDidChange cursorPosition: CGRect) {
        parent.onCursorPositionChange?(cursorPosition)
    }

    public func richEditorView(_ richEditorView: RichEditorView, selectedTextAttributesDidChange textAttributes: TextAttributes) {
        parent.onTextAttributesChange?(textAttributes)
    }
}
