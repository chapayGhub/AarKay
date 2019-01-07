//
//  PackageDependencySpec.swift
//  AarKayRunnerKitTests
//
//  Created by RahulKatariya on 06/01/19.
//

import Quick
import Nimble
@testable import AarKayRunnerKit

class PackageDependencySpec: QuickSpec {
    override func spec() {
        describe("PackageDependency") {
            it("should work with https and suffix git") {
                let packageString = "https://github.com/RahulKatariya/AarKay.git, 0.0.0"
                guard let dep = try? PackageDependency(string: packageString) else {
                    fail("Dep should not be nil"); return
                }
                expect(dep.packageDescription()) == ".package(url: \"https://github.com/RahulKatariya/AarKay.git\", .exact(\"0.0.0\")),"
                expect(dep.targetDescription()) == "\"AarKay\","
            }
            
            it("should work with https and no git") {
                let packageString = "https://github.com/RahulKatariya/AarKay, ~> 0.0.0"
                guard let dep = try? PackageDependency(string: packageString) else {
                    fail("Dep should not be nil"); return
                }
                expect(dep.packageDescription()) == ".package(url: \"https://github.com/RahulKatariya/AarKay\", .upToNextMinor(from: \"0.0.0\")),"
                expect(dep.targetDescription()) == "\"AarKay\","
            }
            
            it("should work with relative file url") {
                let packageString = "./RahulKatariya/AarKay, > 0.0.0"
                guard let dep = try? PackageDependency(string: packageString) else {
                    fail("Dep should not be nil"); return
                }
                expect(dep.packageDescription()) == ".package(url: \"./../RahulKatariya/AarKay\", .upToNextMajor(from: \"0.0.0\")),"
                expect(dep.targetDescription()) == "\"AarKay\","
            }
            
            it("should work with absolute file url") {
                let packageString = "/Users/RahulKatariya/AarKay, 0.0.0"
                guard let dep = try? PackageDependency(string: packageString) else {
                    fail("Dep should not be nil"); return
                }
                expect(dep.packageDescription()) == ".package(url: \"/Users/RahulKatariya/AarKay\", .exact(\"0.0.0\")),"
                expect(dep.targetDescription()) == "\"AarKay\","
            }
            
            it("should fail without version") {
                let packageString = "/Users/RahulKatariya/AarKay"
                let dep = try? PackageDependency(string: packageString)
                expect(dep).to(beNil())
            }
            
            it("should fail with incorrect version") {
                let packageString = "/Users/RahulKatariya/AarKay, ~>0.0.0.0"
                let dep = try? PackageDependency(string: packageString)
                expect(dep).to(beNil())
            }
        }
    }
}
