// swift-tools-version: 6.0
// This is a Skip (https://skip.tools) package.
import PackageDescription

let package = Package(
    name: "machindatamatrixxp",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "MachinDataMatrix", type: .dynamic, targets: ["MachinDataMatrix"]),
    ],
    dependencies: [
        .package(url: "https://github.com/TS200010/ItMkLibrary.git", branch: "main"),
        .package(url: "https://github.com/TS200010/CodeScanneriOS.git", branch: "main"),
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.16"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "MachinDataMatrix", dependencies: [
            .product(name: "SkipUI", package: "skip-ui"),
            .product(name: "ItMkLibrary", package: "ItMkLibrary"),
            .product(name: "CodeScanneriOS", package: "CodeScanneriOS")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "MachinDataMatrixTests", dependencies: [
            "MachinDataMatrix",
            .product(name: "SkipTest", package: "skip")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
