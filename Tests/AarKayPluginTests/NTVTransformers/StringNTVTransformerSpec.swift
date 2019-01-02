//
//  StringNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Quick
import Nimble
@testable import AarKayPlugin

class StringNTVTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("StringNTVTransformer") {
            
            ["String", "String?", "String!"].forEach { type in
                it("works with \(type) Type") {
                    guard let expected = TypeValueTransformer(type: type, value: "Hello, World!")?.value as? String else {
                        fail("It should return the type as \(type)")
                        return
                    }
                    
                    expect(expected).to(equal("Hello, World!"))
                }
            }
            
        }
        
    }
    
}
