//
//  VersionTypeSpec.swift
//  AarKayRunnerKitTests
//
//  Created by RahulKatariya on 06/01/19.
//

import Nimble
import Quick
@testable import AarKayRunnerKit

class VersionTypeSpec: QuickSpec {
    override func spec() {
        describe("VersionType") {
            context("when the input is right") {
                let versionMapping = [
                    ("0.0.0", ".exact(\"0.0.0\")"),
                    ("~> 0.0.0", ".upToNextMinor(from: \"0.0.0\")"),
                    (" 1.1.1 ", ".exact(\"1.1.1\")"),
                    ("> 1.3.0", ".upToNextMajor(from: \"1.3.0\")"),
                    ("~> 1.4.5", ".upToNextMinor(from: \"1.4.5\")"),
                    ("b-master", ".branch(\"master\")"),
                    (" b-develop ", ".branch(\"develop\")"),
                    ("r-3483de34e2432", ".revision(\"3483de34e2432\")"),
                ]

                versionMapping.forEach { string, description in
                    it("should pass") {
                        let version = try? VersionType(string: string)
                        expect(version?.description()) == description
                    }
                }
            }

            context("when the input is wrong") {
                let failVersions = [
                    " 0.0.0.0",
                    "1.1",
                    "~> 1.1",
                    "1.1.r",
                    "~>1.0.3.0",
                    "~> 0.0.0.0",
                    "~>1.0",
                    "~>1.4.5",
                    "master",
                    "b-",
                    "r3483d",
                ]

                failVersions.forEach { string in
                    it("should fail") {
                        let version = try? VersionType(string: string)
                        expect(version).to(beNil())
                    }
                }
            }
        }
    }
}
