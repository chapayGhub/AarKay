import XCTest
@testable import AarKayKitTests
@testable import AarKayPluginTests
@testable import AarKayTests

XCTMain(
    [
        testCase(AarKayTests.allTests),
        testCase(AarKayKitTests.allTests),
        testCase(AarKayPluginTests.allTests),
    ]
)
