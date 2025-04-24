// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "PrettyLogger",
    platforms: [
        .iOS("16"),
        .macCatalyst("16"),
        .tvOS("16"),
        .watchOS("7.0"),
        .macOS("12"),
    ],
    products: [
        .library(
            name: "PrettyLogger",
            targets: ["PrettyLogger"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PrettyLogger",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "PrettyLoggerTests",
            dependencies: ["PrettyLogger"],
            path: "Tests"
        ),
    ]
)
