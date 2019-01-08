//
//  NameTypeValueSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

class NameTypeValueSpec: QuickSpec {
    override func spec() {
        describe("NameTypeValue") {
            it("works") {
                let string = "1|2|someString|||10.01"
                let names = ["bool", "int", "string", "string?", "double?", "float"]
                let types = ["Bool", "Int", "String", "String?", "Double?", "Float"]
                let ntv = try! NameTypeValue(names: names, types: types, value: string).toDictionary()

                expect((ntv["bool"] as! Bool)).to(equal(true))
                expect((ntv["int"] as! Int)).to(equal(2))
                expect((ntv["string"] as! String)).to(equal("someString"))
                expect(ntv["string?"] as? String).to(beEmpty())
                expect(ntv["double?"]).to(beNil())
                expect((ntv["float"] as! Float)).to(equal(10.01))
            }
        }
    }
}
