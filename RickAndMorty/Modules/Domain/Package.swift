// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        .library(name: "Domain", targets: ["Domain"])
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.3")
    ],
    targets: [
        .target(name: "Domain", dependencies: ["Factory"]),
        .testTarget(name: "DomainTests", dependencies: ["Domain"])
    ]
)
