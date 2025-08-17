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
import SwiftUI

struct ReadOnlyEditorView: View {
    @State private var html = """
    <h1>Read-Only Editor Demo</h1>
    <p>This is a <strong>read-only</strong> rich HTML editor. You can:</p>
    <ul>
        <li>Select text by clicking and dragging</li>
        <li>Copy text using Cmd+C (or Ctrl+C on Windows)</li>
        <li>Try to paste content using Cmd+V (but it won't work in read-only mode)</li>
    </ul>
    <p>However, you <em>cannot</em> edit, type, or modify the content in any way.</p>
    <blockquote>
        <p>This demonstrates how the editor preserves text selection and copy functionality while preventing any modifications.</p>
    </blockquote>
    """
    
    @State private var isReadOnly = true
    @StateObject private var textAttributes = TextAttributes()

    var body: some View {
        VStack {
            Toggle("Read-Only Mode", isOn: $isReadOnly)
                .padding()
            
            RichHTMLEditor(html: $html, textAttributes: textAttributes)
                .editorReadOnly(isReadOnly)
                .editorScrollable(true)
                .border(isReadOnly ? Color.gray : Color.blue, width: 2)
        }
        .padding()
    }
}

#Preview {
    ReadOnlyEditorView()
}
