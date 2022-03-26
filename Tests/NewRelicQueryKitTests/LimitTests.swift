@testable import NewRelicQueryKit
import XCTest

class LimitTests: XCTestCase {

    func testCount() {
        let sut: Limit = .count(5)
        XCTAssertEqual(sut.stringRepresentation(), "5")
    }

    func testMax() {
        let sut: Limit = .max
        XCTAssertEqual(sut.stringRepresentation(), "MAX")
    }

}
