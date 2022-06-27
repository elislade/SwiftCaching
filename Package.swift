// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftCaching",
    platforms: [.macOS(.v10_11), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "SwiftCaching", targets: ["SwiftCaching"]),
    ],
    targets: [
        .target(name: "SwiftCaching", dependencies: []),
        .testTarget(name: "SwiftCachingTests", dependencies: ["SwiftCaching"]),
    ]
)
