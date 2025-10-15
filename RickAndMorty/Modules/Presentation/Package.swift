// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Presentation",
    products: [
        .library(name: "Presentation", targets: ["Presentation"])
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(name: "Presentation", dependencies: ["Domain"]),
        .testTarget(name: "PresentationTests", dependencies: ["Presentation"])
    ]
)
