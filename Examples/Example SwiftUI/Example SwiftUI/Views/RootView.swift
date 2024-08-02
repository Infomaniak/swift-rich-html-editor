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

enum EditorState: String, CaseIterable {
    case scrollable = "Scrollable"
    case notScrollable = "Not Scrollable"
    case fixedSize = "Fixed Size"
}

struct RootView: View {
    @State private var editorState = EditorState.scrollable

    var body: some View {
        NavigationStack {
            Group {
                switch editorState {
                case .scrollable:
                    ScrollableEditorView()
                case .notScrollable:
                    NotScrollableEditorView()
                case .fixedSize:
                    FixedSizeEditorView()
                }
            }
            .navigationTitle("Infomaniak - RichHTMLEditor (SwiftUI)")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("Switch Editor State", selection: $editorState) {
                        ForEach(EditorState.allCases, id: \.self) { state in
                            Text(state.rawValue)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RootView()
}
