//
//  FloatNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

class FloatNTVTransformerSpec: QuickSpec {
    override func spec() {
        describe("FloatNTVTransformer") {
            it("works with Float Type") {
                let value = TypeValueTransformer(type: "Float", value: "10")?.value
                guard let expected = value as? Float else {
                    fail("It should return the type as Float")
                    return
                }

                expect(expected).to(equal(10.0))
            }

            context("when value is unknown") {
                it("should return nil") {
                    expect(TypeValueTransformer(type: "Float", value: "any")?.value).to(beNil())
                }
            }
        }
    }
}
