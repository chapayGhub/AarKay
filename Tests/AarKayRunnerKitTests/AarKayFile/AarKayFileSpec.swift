//
//  AarKayFileSpec.swift
//  AarKayRunnerKitTests
//
//  Created by RahulKatariya on 07/01/19.
//

import Nimble
import Quick
@testable import AarKayRunnerKit

class AarKayFileSpec: QuickSpec {
    override func spec() {
        describe("AarKayFile") {
            it("should work for correct format") {
                let aarkayFileContents = """
                https://github.com/RahulKatariya/AarKay.git, b-master
                ./../aarkay-plugin-test, ~> 0.0.0
                /Users/Developer/Restofire/Restofire, > 1.1.0
                """
                guard let deps = try? AarKayFile(contents: aarkayFileContents).dependencies else {
                    fail("aarkayFile should not be nil"); return
                }
                expect(deps.count) == 3

                expect(deps[0].url.absoluteString) == "https://github.com/RahulKatariya/AarKay.git"
                expect(deps[0].version) == .branch("master")

                expect(deps[1].url.absoluteString) == "./../aarkay-plugin-test"
                expect(deps[1].version) == .upToNextMinor("0.0.0")

                expect(deps[2].url.absoluteString) == "/Users/Developer/Restofire/Restofire"
                expect(deps[2].version) == .upToNextMajor("1.1.0")
            }

            it("should fail for incorrect format") {
                let aarkayFileContents = """
                https://github.com/RahulKatariya/AarKay.git
                ./../aarkay-plugin-test, ~> 0.0.0
                """
                let deps = try? AarKayFile(contents: aarkayFileContents).dependencies
                expect(deps).to(beNil())
            }
        }
    }
}
