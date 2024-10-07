// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfomaniakRichHTMLEditor",
    platforms: [
        .iOS(.v14),
        .visionOS(.v1),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "InfomaniakRichHTMLEditor",
            targets: ["InfomaniakRichHTMLEditor"]
        )
    ],
    targets: [
        .target(
            name: "InfomaniakRichHTMLEditor",
            resources: [
                .process("Resources/")
            ]
        ),
        .testTarget(
            name: "InfomaniakRichHTMLEditorTests",
            dependencies: ["InfomaniakRichHTMLEditor"]
        )
    ]
)
