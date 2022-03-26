// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NewRelicQueryKit",
    products: [
        .library(name: "NewRelicQueryKit", targets: ["NewRelicQueryKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "NewRelicQueryKit", dependencies: []),
        .testTarget(name: "NewRelicQueryKitTests", dependencies: ["NewRelicQueryKit"]),
    ]
)
