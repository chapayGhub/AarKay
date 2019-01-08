//
//  UnknownNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

class UnknownNTVTransformerSpec: QuickSpec {
    override func spec() {
        describe("UnknownNTVTransformer") {
            it("should return nil") {
                let value = TypeValueTransformer(type: "Unknown", value: "Hello, World!")?.value
                expect(value).to(beNil())
            }
        }
    }
}
