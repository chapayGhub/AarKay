// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AarKay{{ cookiecutter.name }}",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "AarKay{{ cookiecutter.name }}CLI",
            targets: ["AarKay{{ cookiecutter.name }}CLI"]
        ),
        .library(
            name: "aarkay-plugin-{{ cookiecutter.name|lower}}",
            targets: ["aarkay-plugin-{{ cookiecutter.name|lower}}"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/RahulKatariya/AarKay.git", .upToNextMinor(from: "0.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AarKay{{ cookiecutter.name }}CLI",
            dependencies: ["aarkay-plugin-{{ cookiecutter.name|lower}}", "AarKay"]
        ),
        .target(
            name: "aarkay-plugin-{{ cookiecutter.name|lower}}",
            dependencies: ["AarKayPlugin"],
            path: "Sources/AarKay{{ cookiecutter.name }}"
        ),
    ],
    swiftLanguageVersions: [4]
)
