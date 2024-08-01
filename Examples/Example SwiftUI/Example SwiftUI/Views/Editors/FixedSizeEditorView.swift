//
//  FixedSizeEditorView.swift
//  Example SwiftUI
//
//  Created by Valentin Perignon on 01/08/2024.
//

import InfomaniakRichHTMLEditor
import SwiftUI

struct FixedSizeEditorView: View {
    @State private var html = ""
    @StateObject private var textAttributes = TextAttributes()

    var body: some View {
        RichHTMLEditor(html: $html, textAttributes: textAttributes)
            .editorScrollable(true)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .padding(16)
            .frame(height: 200)
    }
}

#Preview {
    FixedSizeEditorView()
}
