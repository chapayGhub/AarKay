//
//  FloatNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Quick
import Nimble
@testable import AarKayPlugin

class FloatNTVTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("FloatNTVTransformer") {
            
            ["Float", "Float?", "Float!"].forEach { type in
                it("works with \(type) Type") {
                    guard let expected = TypeValueTransformer(type: type, value: "10")?.value as? Float else {
                        fail("It should return the type as \(type)")
                        return
                    }
                    
                    expect(expected).to(equal(10.0))
                }
                
                context("when value is unknown") {
                    it("should return nil") {
                        expect(TypeValueTransformer(type: type, value: "any")?.value).to(beNil())
                    }
                }
            }
            
        }
        
    }
    
}
