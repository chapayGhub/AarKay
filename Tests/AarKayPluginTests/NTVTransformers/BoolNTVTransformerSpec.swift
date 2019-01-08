//
//  BoolNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

class BoolNTVTransformerSpec: QuickSpec {
    override func spec() {
        describe("BoolNTVTransformer") {
            context("when value is true") {
                it("should be true with Bool Type") {
                    let value = TypeValueTransformer(type: "Bool", value: "true")?.value
                    guard let expected = value as? Bool else {
                        fail("It should return the type as Bool")
                        return
                    }

                    expect(expected).to(beTruthy())
                }
            }

            context("when value is yes") {
                it("should be true with Bool Type") {
                    let value = TypeValueTransformer(type: "Bool", value: "yes")?.value
                    guard let expected = value as? Bool else {
                        fail("It should return the type as Bool")
                        return
                    }

                    expect(expected).to(beTruthy())
                }
            }

            context("when value is 1") {
                it("should be true with Bool Type") {
                    let value = TypeValueTransformer(type: "Bool", value: "1")?.value
                    guard let expected = value as? Bool else {
                        fail("It should return the type as Bool")
                        return
                    }

                    expect(expected).to(beTruthy())
                }
            }

            context("when value is false") {
                it("should be false with Bool Type") {
                    let value = TypeValueTransformer(type: "Bool", value: "false")?.value
                    guard let expected = value as? Bool else {
                        fail("It should return the type as Bool")
                        return
                    }

                    expect(expected).to(beFalsy())
                }
            }

            context("when value is no") {
                it("should be false with Bool Type") {
                    let value = TypeValueTransformer(type: "Bool", value: "no")?.value
                    guard let expected = value as? Bool else {
                        fail("It should return the type as Bool")
                        return
                    }

                    expect(expected).to(beFalsy())
                }
            }

            context("when value is 0") {
                it("should be false with Bool Type") {
                    let value = TypeValueTransformer(type: "Bool", value: "0")?.value
                    guard let expected = value as? Bool else {
                        fail("It should return the type as Bool")
                        return
                    }

                    expect(expected).to(beFalsy())
                }
            }

            context("when value is unknown") {
                it("should be false with Bool Type") {
                    expect(TypeValueTransformer(type: "Bool", value: "any")?.value).to(beNil())
                }
            }
        }
    }
}
