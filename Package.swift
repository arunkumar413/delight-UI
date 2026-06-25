// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swift-tools-version: 6.0

let package = Package(
    name: "delight-ui",

    products: [
        .library(
            name: "delight-ui",
            targets: ["delight-ui"]
        ),
        .executable(
            name: "test-exe",  // Name of your CLI tool
            targets: ["test-exe"]
        ),
    ],

    dependencies: [
        .package(
            url: "https://github.com/react/yoga.git",
            from: "3.2.1"
        )
    ],

    targets: [
        .systemLibrary(
            name: "CSDL"
        ),
        .target(
            name: "delight-ui",
            dependencies: [
                .product(
                    name: "yoga",
                    package: "yoga"
                ),
                "CSDL",

            ],
            linkerSettings: [
                .linkedLibrary("m")
            ]
        ),
        .executableTarget(
            name: "test-exe",
            dependencies: ["delight-ui"]
        ),
    ]

)
