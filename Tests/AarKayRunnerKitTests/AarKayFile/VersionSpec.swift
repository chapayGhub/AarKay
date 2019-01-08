//
//  VersionSpec.swift
//  AarKayRunnerKitTests
//
//  Created by RahulKatariya on 06/01/19.
//

import Nimble
import Quick
@testable import AarKayRunnerKit

class VersionSpec: QuickSpec {
    override func spec() {
        describe("Version") {
            it("should work for major minor patch") {
                let version = try? Version(string: "0.0.0")
                expect(version?.description()) == "0.0.0"
            }

            it("should fail for major minor") {
                let version = try? Version(string: "0.0")
                expect(version).to(beNil())
            }

            it("should fail for string in version") {
                let version = try? Version(string: "r.4.k")
                expect(version).to(beNil())
            }
        }
    }
}
