//
//  IntNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

class IntNTVTransformerSpec: QuickSpec {
    override func spec() {
        describe("IntNTVTransformer") {
            it("works with Int Type") {
                let value = TypeValueTransformer(type: "Int", value: "10")?.value
                guard let expected = value as? Int else {
                    fail("It should return the type as Int")
                    return
                }

                expect(expected).to(equal(10))
            }

            context("when value is unknown") {
                it("should return nil") {
                    expect(TypeValueTransformer(type: "Int", value: "any")?.value).to(beNil())
                }
            }
        }
    }
}
