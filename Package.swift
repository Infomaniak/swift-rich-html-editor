// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfomaniakRichEditor",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "InfomaniakRichEditor",
            targets: ["InfomaniakRichEditor"]
        ),
    ],
    targets: [
        .target(
            name: "InfomaniakRichEditor",
            resources: [
                .process("Resources/index.html"),
                .process("Resources/js/captureLog.js"),
                .process("Resources/js/editor.js"),
                .process("Resources/js/javascriptBridge.js"),
                .process("Resources/css/style.css"),
            ]
        ),
        .testTarget(
            name: "InfomaniakRichEditorTests",
            dependencies: ["InfomaniakRichEditor"]
        ),
    ]
)
