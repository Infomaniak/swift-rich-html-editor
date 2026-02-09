//
//  NotScrollableEditorView.swift
//  Example SwiftUI
//
//  Created by Valentin Perignon on 01/08/2024.
//

import InfomaniakRichHTMLEditor
import SwiftUI

struct NotScrollableEditorView: View {
    @State private var html = "<h1>NotScrollableEditorView</h1><p>This editor is not scrollable and will expand to fit its content.</p>"
    @StateObject private var textAttributes = TextAttributes()

    var body: some View {
        ScrollView {
            RichHTMLEditor(html: $html, textAttributes: textAttributes)
        }
    }
}

#Preview {
    NotScrollableEditorView()
}
