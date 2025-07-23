import XCTest

@testable import PrettyLogger

class LegacyFormatOutputTests: XCTestCase {
    func testLegacyOutputWithTwoParameters() {
        PrettyLogger.shared.level = .info
        PrettyLogger.shared.separator = " ❎ "
        let output = logInfo("2", "3")

        XCTAssertEqual(output?.contains("2 ❎ 3"), true)
    }
}
