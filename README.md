# AarKay

<img src="https://raw.githubusercontent.com/RahulKatariya/AarKay/master/.github/logo.png" width="100">

[<img src="https://img.shields.io/badge/language-Swift-orange.svg?longCache=true&style=flat-square">](https://github.com/Apple/Swift) [<img src="https://rahulkatariya.herokuapp.com/badge.svg?longCache=true&style=flat-square">](https://rahulkatariya.herokuapp.com)

AarKay is a language independent code generation framework which allows you to apply data to your personal [templates](https://github.com/RahulKatariya/AarKay/blob/master/guides/Templatefile.md) and generates code for you with empty placeholders for custom logics.

<p align="center"><img src="https://raw.githubusercontent.com/RahulKatariya/AarKay/master/.github/1.png"></p>

## Why AarKay?

AarKay allows you to generate code from [templates](https://github.com/RahulKatariya/AarKay/blob/master/guides/Templatefile.md), encouraging best coding practices.

- Focus on architecture and design rather than writing code.
- Enforces same architecture and coding style across large teams and projects
- Automatic generated code means less error-prone code
- Helps save time during code review
- Helps getting bird's eye view of a large project

## Installation

- _Binary form_

Download the latest release with the prebuilt binary from [release tab](https://github.com/RahulKatariya/AarKay/releases/latest). Unzip the archive into the desired destination and run `bin/aarkay`.

- _[Homebrew](https://brew.sh)_

`brew install rahulkatariya/formulae/aarkay`

# Getting Started

There are plenty of tutorials for different uses of AarKay:

- [AarKay - A code generation framework for all languages](https://medium.com/rahulkatariya/aarkay-a-code-generator-for-all-developers-65f3803db704)
- [Swift Networking Code Generation using AarKay](https://medium.com/rahulkatariya/generating-swift-network-code-using-aarkay-64ad6d49d337)

# Plugins

Plugins allows you to

- Process and Modify [Datafile](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) data before it is applied to the [Template](https://github.com/RahulKatariya/AarKay/blob/master/guides/Templatefile.md).
- Modify Generatedfile name and directory.
- Generates multiple files of any type with the same data.

### Available Plugins

- [Restofire](https://github.com/Restofire/aarkay-plugin-restofire)
- [CoreData](https://github.com/RahulKatariya/aarkay-plugin-coredata)
- [Uber RIBs](https://github.com/RahulKatariya/aarkay-plugin-uberribs)

# Attributions

- [Stencil](https://github.com/stencilproject/Stencil)
- [Yams](https://github.com/jpsim/Yams)
- [Commandant](https://github.com/Carthage/Commandant.git)

# Contributing

Issues and Pull Requests are welcome!

# Author

Created with ❤️ by [Rahul Katariya](https://twitter.com/rahulkatariya91)
