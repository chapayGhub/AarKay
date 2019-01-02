//
//  UnknownNTVTransformerSpec.swift
//  AarKayPluginTests
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import Quick
import Nimble
@testable import AarKayPlugin

class UnknownNTVTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("UnknownNTVTransformer") {
            
            ["Unknown", "Unknown?", "Unknown!"].forEach { type in
                it("should return nil") {
                    expect(TypeValueTransformer(type: type, value: "Hello, World!")?.value).to(beNil())
                }
            }
            
        }
        
    }
    
}
