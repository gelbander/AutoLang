// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AutoLang",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "AutoLang",
            dependencies: ["Yams"],
            path: "AutoLang"
        )
    ]
)