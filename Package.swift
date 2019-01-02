// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AarKay",
    products: [
        .library(name: "AarKay", targets: ["AarKay"]),
        .library(name: "AarKayKit", targets: ["AarKayKit"]),
        .library(name: "AarKayPlugin", targets: ["AarKayPlugin"]),
        .executable(name: "AarKayCLI", targets: ["AarKayCLI"]),
        .executable(name: "AarKayRunner", targets: ["AarKayRunner"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        /* ------------------------------------------------------ */
        /* >>> AarKayKit ------------------------------------------- */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", .upToNextMajor(from: "2.5.0")),
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/antitypical/Result.git", .upToNextMajor(from: "4.0.0")),
        /* ------------------------------------------------------ */
        /* >>> CLI ---------------------------------------------- */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/jdhealy/PrettyColors.git", .exact("5.0.1")),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", .exact("0.8.0")),
        .package(url: "https://github.com/RahulKatariya/Willow.git", .upToNextMajor(from: "5.0.0")),
        /* ------------------------------------------------------ */
        /* >>> Runner ------------------------------------------- */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/thoughtbot/Curry.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Carthage/Commandant.git", .upToNextMinor(from: "0.15.0")),
        .package(url: "https://github.com/RahulKatariya/ReactiveTask.git", .upToNextMinor(from: "0.15.0")),
        /* ------------------------------------------------------ */
        /* >>> Testing ------------------------------------------ */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AarKay",
            dependencies: ["AarKayKit", "PrettyColors", "SwiftyTextTable", "Willow"]
        ),
        .target(
            name: "AarKayKit",
            dependencies: ["StencilSwiftKit", "Result", "Yams"]
        ),
          .target(
            name: "AarKayPlugin",
            dependencies: ["AarKayKit"]
        ),
        .target(
            name: "AarKayCLI",
            dependencies: ["AarKay", "AarKayPlugin"]
        ),
        .target(
            name: "AarKayRunner",
            dependencies: ["Commandant", "ReactiveTask", "Curry"]
        ),
        .testTarget(
            name: "AarKayTests",
            dependencies: ["AarKay", "Quick", "Nimble"]
        ),
        .testTarget(
            name: "AarKayPluginTests",
            dependencies: ["AarKayPlugin", "Quick", "Nimble"]
        ),
        .testTarget(
            name: "AarKayKitTests",
            dependencies: ["AarKayKit", "Quick", "Nimble"]
        ),
    ],
    swiftLanguageVersions: [.v4, .v4_2]
)
