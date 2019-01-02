//
//  CustomNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Quick
import Nimble
@testable import AarKayPlugin

struct Custom {
    let value: String
}

extension Custom: Equatable {
    static func ==(lhs: Custom, rhs: Custom) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Custom: TypeValueTransformable {
    
    static func transform(value: String) -> Custom? {
        return Custom(value: value)
    }
    
}

class CustomNTVTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("CustomNTVTransformer") {
            
            TypeValueTransformer.register(transformer: Custom.self)
            
            ["Custom", "Custom?", "Custom!"].forEach { type in
                it("works with \(type) Type") {
                    guard let expected = TypeValueTransformer(type: type, value: "custom")?.value as? Custom else {
                        fail("It should return the type as \(type)")
                        return
                    }
                    
                    expect(expected).to(equal(Custom(value: "custom")))
                }
            }
            
        }
        
    }
    
}
