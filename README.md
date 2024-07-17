# Infomaniak Rich HTML Editor

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FInfomaniak%2Fswift-rich-html-editor%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Infomaniak/swift-rich-html-editor)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FInfomaniak%2Fswift-rich-html-editor%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Infomaniak/swift-rich-html-editor)

The **Infomaniak Rich HTML Editor** is a powerful Swift package designed to provide a seamless WYSIWYG (What You See Is What You Get) text editing experience across iOS, macOS, and visionOS platforms. Leveraging the power of the `contenteditable` HTML attribute, this editor allows you to effortlessly edit HTML content.

Built with UIKit and AppKit across WebKit, it also includes a SwiftUI port, making it easy to integrate into modern Swift apps.

<table>
    <tr>
        <td>
            <img src="Assets/ios.webp" alt="iOS sample app" style="max-height: 250px">
        </td>
        <td>
            <img src="Assets/macos.webp" alt="iOS sample app" style="max-height: 250px">
        </td>
        <td>
            <img src="Assets/visionos.webp" alt="iOS sample app" style="max-height: 250px">
        </td>
    </tr>
</table>

## ✍️ About

### Features

- **WYSIWYG Editing**: Provides a rich text editing interface where the displayed text closely resembles its final output.
- **HTML Content Editing**: Full support for editing and managing HTML content directly.
- **Cross-Platform Support:** Compatible with iOS, macOS, and visionOS.
- **SwiftUI API**: A dedicated port for SwiftUI, ensuring modern and declarative UI design compatibility.

### Installation

You can install the package via Swift Package Manager. Add the following line to your Package.swift file:
```swift
.package(url: "https://github.com/Infomaniak/swift-rich-html-editor.git", from: "1.0.0")
```

### Usage

#### UIKit and AppKit

You can create the editor view and then add it to the view hierarchy.
```swift
import RichHTMLEditor

let editor = RichHTMLEditorView()
view.addSubview(editor)
```

#### SwiftUI

You can create append the view to your hierarchy.
```swift
import RichHTMLEditor

struct ContentView: View {
    @State private var html = ""
    @StateObject private var textAttributes = TextAttributes()

    var body: some View {
        RichHTMLEditor(html: $html, textAttributes: $textAttributes)
    }
}
```

## 📖 Documentation

TODO.

## 🔍 Sample Projects

You can find 3 sample projects in the [Examples](Examples) folder:
- A [project built with UIKit](Examples/Example%20iOS/) for iOS
- A [project built with AppKi](Examples/Example%20macOS/) for macOS
- A [project build with SwiftUI](Examples/Example%20SwiftUI/) for iOS/macOS/visionOS

## 📱 Apps using InfomaniakRichHTMLEditor

<a href="https://github.com/Infomaniak/ios-kMail">
    <img src="Assets/infomaniak-mail.webp" height="300" alt="Find App">
</a>

[Infomaniak Mail](https://github.com/Infomaniak/ios-kMail) allows you to manage your Infomaniak addresses in a completely secure environment.
