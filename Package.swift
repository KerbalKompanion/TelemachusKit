// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TelemachusKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TelemachusKit",
            targets: ["TelemachusKit"]),
    ],
    dependencies: [
         .package(url: "https://github.com/daltoniam/Starscream", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "TelemachusKit",
            dependencies: ["Starscream"]),
        .testTarget(
            name: "TelemachusKitTests",
            dependencies: ["TelemachusKit"]),
    ]
)
