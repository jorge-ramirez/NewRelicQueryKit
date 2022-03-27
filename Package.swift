// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NewRelicQueryKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
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
