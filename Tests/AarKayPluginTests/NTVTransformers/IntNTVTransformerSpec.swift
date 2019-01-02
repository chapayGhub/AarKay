//
//  IntNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Quick
import Nimble
@testable import AarKayPlugin

class IntNTVTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("IntNTVTransformer") {
            
            ["Int", "Int?", "Int!"].forEach { type in
                it("works with \(type) Type") {
                    guard let expected = TypeValueTransformer(type: type, value: "10")?.value as? Int else {
                        fail("It should return the type as \(type)")
                        return
                    }
                    
                    expect(expected).to(equal(10))
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
