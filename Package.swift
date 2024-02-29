// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfomaniakRichEditor",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "InfomaniakRichEditor",
            targets: ["InfomaniakRichEditor"]),
    ],
    targets: [
        .target(
            name: "InfomaniakRichEditor"),
        .testTarget(
            name: "InfomaniakRichEditorTests",
            dependencies: ["InfomaniakRichEditor"]),
    ]
)
