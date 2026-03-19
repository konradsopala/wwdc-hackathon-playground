// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HackathonPlayground",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "HackathonPlayground",
            targets: ["HackathonPlayground"]),
    ],
    targets: [
        .target(
            name: "HackathonPlayground",
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "HackathonPlaygroundTests",
            dependencies: ["HackathonPlayground"]),
    ]
)
