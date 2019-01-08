//
//  DoubleNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

class DoubleNTVTransformerSpec: QuickSpec {
    override func spec() {
        describe("DoubleNTVTransformer") {
            it("works with Double Type") {
                let value = TypeValueTransformer(type: "Double", value: "10")?.value
                guard let expected = value as? Double else {
                    fail("It should return the type as Double")
                    return
                }

                expect(expected).to(equal(10.0))
            }

            context("when value is unknown") {
                it("should return nil") {
                    expect(TypeValueTransformer(type: "Double", value: "any")?.value).to(beNil())
                }
            }
        }
    }
}
