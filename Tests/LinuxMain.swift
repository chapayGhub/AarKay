import XCTest
@testable import AarKayKitTests
@testable import AarKayPluginTests

XCTMain([
    testCase(AarKayKitTests.allTests),
    testCase(AarKayPluginTests.allTests),
])
