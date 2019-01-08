//
//  CustomNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Nimble
import Quick
@testable import AarKayPlugin

struct Custom {
    let value: String
}

extension Custom: Equatable {
    static func == (lhs: Custom, rhs: Custom) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Custom: StringTransformable {
    static func transform(value: String) -> Custom? {
        return Custom(value: value)
    }
}

class CustomNTVTransformerSpec: QuickSpec {
    override func spec() {
        describe("CustomNTVTransformer") {
            TypeValueTransformer.register(transformer: Custom.self)

            it("works with Custom Type") {
                let value = TypeValueTransformer(type: "Custom", value: "custom")?.value
                guard let expected = value as? Custom else {
                    fail("It should return the type as Custom")
                    return
                }

                expect(expected).to(equal(Custom(value: "custom")))
            }
        }
    }
}
