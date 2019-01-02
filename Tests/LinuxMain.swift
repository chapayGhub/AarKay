import XCTest
@testable import AarKayTests
@testable import AarKayKitTests
@testable import AarKayPluginTests

XCTMain([
    testCase(AarKayTests.allTests),
    testCase(AarKayKitTests.allTests),
    testCase(AarKayPluginTests.allTests),
])
