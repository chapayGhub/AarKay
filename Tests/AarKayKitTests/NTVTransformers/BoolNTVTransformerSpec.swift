//
//  BoolNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Quick
import Nimble
@testable import AarKayKit

class BoolNTVTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("BoolNTVTransformer") {
            
            ["Bool", "Bool?", "Bool!"].forEach { type in
                
                context("when value is true") {
                    it("should be true with \(type) Type") {
                        guard let expected = TypeValueTransformer(type: type, value: "true")?.value as? Bool else {
                            fail("It should return the type as \(type)")
                            return
                        }
                        
                        expect(expected).to(beTruthy())
                    }
                }
                
                context("when value is yes") {
                    it("should be true with \(type) Type") {
                        guard let expected = TypeValueTransformer(type: type, value: "yes")?.value as? Bool else {
                            fail("It should return the type as Bool")
                            return
                        }
                        
                        expect(expected).to(beTruthy())
                    }
                }
                
                context("when value is 1") {
                    it("should be true with \(type) Type") {
                        guard let expected = TypeValueTransformer(type: type, value: "1")?.value as? Bool else {
                            fail("It should return the type as Bool")
                            return
                        }
                        
                        expect(expected).to(beTruthy())
                    }
                }
                
                context("when value is false") {
                    it("should be false with \(type) Type") {
                        guard let expected = TypeValueTransformer(type: type, value: "false")?.value as? Bool else {
                            fail("It should return the type as Bool")
                            return
                        }
                        
                        expect(expected).to(beFalsy())
                    }
                }
                
                context("when value is no") {
                    it("should be false with \(type) Type") {
                        guard let expected = TypeValueTransformer(type: type, value: "no")?.value as? Bool else {
                            fail("It should return the type as Bool")
                            return
                        }
                        
                        expect(expected).to(beFalsy())
                    }
                }
                
                context("when value is 0") {
                    it("should be false with \(type) Type") {
                        guard let expected = TypeValueTransformer(type: type, value: "0")?.value as? Bool else {
                            fail("It should return the type as Bool")
                            return
                        }
                        
                        expect(expected).to(beFalsy())
                    }
                }
                
                context("when value is unknown") {
                    it("should be false with \(type) Type") {
                        expect(TypeValueTransformer(type: type, value: "any")?.value).to(beNil())
                    }
                }
                
            }
            
        }
        
    }
    
}
