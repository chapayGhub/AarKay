// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AarKay",
    products: [
        .library(name: "AarKay", targets: ["AarKay"]),
        .executable(name: "AarKayCLI", targets: ["AarKayCLI"]),
        .executable(name: "AarKayRunner", targets: ["AarKayRunner"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        /* ------------------------------------------------------ */
        /* >>> AarKayKit ---------------------------------------- */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/RahulKatariya/AarKayKit.git", .upToNextMajor(from: "0.0.0")),
        /* ------------------------------------------------------ */
        /* >>> CLI ---------------------------------------------- */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/jdhealy/PrettyColors.git", .exact("5.0.1")),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", .exact("0.8.0")),
        /* ------------------------------------------------------ */
        /* >>> Runner ------------------------------------------- */
        /* ------------------------------------------------------ */
        .package(url: "https://github.com/Carthage/Commandant.git", .upToNextMinor(from: "0.15.0")),
        .package(url: "https://github.com/RahulKatariya/ReactiveTask.git", .upToNextMinor(from: "0.15.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AarKay",
            dependencies: ["AarKayKit", "PrettyColors", "SwiftyTextTable"]
        ),
        .target(
            name: "AarKayCLI",
            dependencies: ["AarKay", "AarKayPlugin"]
        ),
        .target(
            name: "AarKayRunner",
            dependencies: ["Commandant", "ReactiveTask"]
        ),
    ],
    swiftLanguageVersions: [4]
)
