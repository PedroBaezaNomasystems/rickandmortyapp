// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [
        .iOS(.v16)
    ],
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
