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
        .package(url: "https://github.com/cx-org/CXShim", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/lavalleeale/CombineX", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Swimmy",
            dependencies: [
                .product(name: "CXShim", package: "CXShim"),
                .product(name: "CombineX", package: "CombineX"),
            ],
            swiftSettings: [.enableUpcomingFeature("BareSlashRegexLiterals")]
        ),
        .testTarget(
            name: "SwimmyTests",
            dependencies: ["Swimmy"]),
    ]
)
