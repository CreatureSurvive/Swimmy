// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swimmy",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Swimmy",
            targets: ["Swimmy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Swimmy",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ],
            swiftSettings: [.enableUpcomingFeature("BareSlashRegexLiterals")]
        ),
        .testTarget(
            name: "SwimmyTests",
            dependencies: ["Swimmy"]),
    ]
)
