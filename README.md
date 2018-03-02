# AarKay

<img src="https://raw.githubusercontent.com/RahulKatariya/AarKay/master/.github/logo.png" width="100">

[<img src="https://img.shields.io/badge/language-Swift-orange.svg?longCache=true&style=flat-square">](https://github.com/Apple/Swift) [<img src="https://rahulkatariya.herokuapp.com/badge.svg?longCache=true&style=flat-square">](https://rahulkatariya.herokuapp.com)

AarKay is a language independent code generation framework which allows you to apply data to your personal [templates](https://github.com/RahulKatariya/AarKay/blob/master/guides/Templatefile.md) and generates code for you with empty placeholders for custom logics.

> Javascript port is under develogpment, contributors are welcome! - [AarKay.js](https://github.com/RahulKatariya/AarKay.js)

<p align="center"><img src="https://raw.githubusercontent.com/RahulKatariya/AarKay/master/.github/1.png"></p>

## Overview

AarKay is installed inside your home directory - `~/AarKay`
- `~/AarKay/AarKayData` is the default location of all your [Datafiles](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) but if you want to commit it inside your repository then you can save your [Datafiles](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) inside - `/{path/to/project}/AarKay/AarKayData`
- `~/AarKay/AarKayTemplates/AarKay` is the default location of all your [Templatefiles](https://github.com/RahulKatariya/AarKay/blob/master/guides/Templatefile.md).
- `~/AarKay/AarKayFile`is the default location of all your Plugins.

AarKay generates the code file inside your home directory `~/`; followed by the path of your [Datafile](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) inside `~/AarKay/AarKayData`.

For example,

- [Datafile](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) at `~/AarKay/AarKayData/File.Template.yml` will generate the code file at `~/File.txt`
- [Datafile](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) at `~/AarKay/AarKayData/Documents/File.Template.yml` will generate the code file at `~/Documents/File.txt`.

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
- [How I manage my tmuxinator files using aarkay](https://medium.com/rahulkatariya/how-i-manage-my-tmuxinator-files-with-aarkay-7f417ace6fb8)
- [Framework Oriented Programming In Swift](https://medium.com/rahulkatariya/framework-oriented-programming-in-swift-4d92db85ff1c)
- [Swift Networking Code Generation using AarKay](https://medium.com/rahulkatariya/generating-swift-network-code-using-aarkay-64ad6d49d337)

# Plugins

Plugins allows you to
- Modify [Datafile](https://github.com/RahulKatariya/AarKay/blob/master/guides/Datafile.md) data before it is applied to the [Template](https://github.com/RahulKatariya/AarKay/blob/master/guides/Templatefile.md)
- Modify Generatedfile name and specify subdirectory
- Generates multiple files of any type with the same data

### Available Plugins

- [aarkay-plugin-restofire](https://github.com/Restofire/aarkay-plugin-restofire)

# Contributing

Issues and Pull Requests are welcome!

# Author

Created with ❤️ by [Rahul Katariya](https://twitter.com/rahulkatariya91)
