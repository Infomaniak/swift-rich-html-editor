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
//
//  EditorWithSwiftUIToolbar.swift
//  InfomaniakRichHTMLEditor
//
//  Created by William Mead on 13/05/2026.
//

import SwiftUI
import InfomaniakRichHTMLEditor

// MARK: - SwiftUI toolbar view
struct EditorSwiftUIToolbarContent: View {
    @ObservedObject var textAttributes: TextAttributes

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                // Text formatting
                EditorToolbarButton(
                    systemImage: "bold",
                    isActive: textAttributes.hasBold
                ) {
                    textAttributes.bold()
                }
                EditorToolbarButton(
                    systemImage: "italic",
                    isActive: textAttributes.hasItalic
                ) {
                    textAttributes.italic()
                }
                EditorToolbarButton(
                    systemImage: "underline",
                    isActive: textAttributes.hasUnderline
                ) {
                    textAttributes.underline()
                }
                EditorToolbarButton(
                    systemImage: "strikethrough",
                    isActive: textAttributes.hasStrikethrough
                ) {
                    textAttributes.strikethrough()
                }
                Divider().frame(height: 20)
                // Lists
                EditorToolbarButton(
                    systemImage: "list.number",
                    isActive: textAttributes.hasOrderedList
                ) {
                    textAttributes.orderedList()
                }
                EditorToolbarButton(
                    systemImage: "list.bullet",
                    isActive: textAttributes.hasUnorderedList
                ) {
                    textAttributes.unorderedList()
                }
                Divider().frame(height: 20)
                // Indentation
                EditorToolbarButton(
                    systemImage: "decrease.indent",
                    isActive: false
                ) {
                    textAttributes.outdent()
                }
                EditorToolbarButton(
                    systemImage: "increase.indent",
                    isActive: false
                ) {
                    textAttributes.indent()
                }
                Divider().frame(height: 20)
                // Undo / Redo
                EditorToolbarButton(
                    systemImage: "arrow.uturn.backward",
                    isActive: false
                ) {
                    textAttributes.undo()
                }
                EditorToolbarButton(
                    systemImage: "arrow.uturn.forward",
                    isActive: false
                ) {
                    textAttributes.redo()
                }
            }
            .fixedSize(horizontal: true, vertical: false)
            .padding(.horizontal, 8)
        }
        .scrollIndicators(.hidden)
        .frame(height: 44)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
        .padding(.horizontal)
    }
}

// MARK: - Toolbar button
struct EditorToolbarButton: View {

    let systemImage: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.body)
                .frame(width: 36, height: 36)
                .foregroundStyle(isActive ? Color.accentColor : .primary)
                .background(isActive ? Color.accentColor.opacity(0.2) : .clear, in: .rect(cornerRadius: 12))
        }
    }

}

// MARK: - UIView wrapper for input accessory

final class EditorSwiftUIToolbar: UIView {

    private let hostingController: UIHostingController<EditorSwiftUIToolbarContent>

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }

    init(textAttributes: TextAttributes) {
        hostingController = UIHostingController(rootView: EditorSwiftUIToolbarContent(textAttributes: textAttributes))
        hostingController.view.backgroundColor = .clear

        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        autoresizingMask = .flexibleWidth

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -
struct EditorWithSwiftUIToolbar: View {
    @State private var html = "<h1>EditorWithToolbar</h1><p>This editor <strong>has a toolbar</strong>. Focus the editor to reveal it. The toolbar can be scrolled horizontally.</p>"
    @StateObject private var textAttributes = TextAttributes()

    var body: some View {
        RichHTMLEditor(html: $html, textAttributes: textAttributes)
            .editorScrollable(true)
            .editorInputAccessoryView(EditorSwiftUIToolbar(textAttributes: textAttributes))
    }
}

#Preview {
    EditorWithSwiftUIToolbar()
}
