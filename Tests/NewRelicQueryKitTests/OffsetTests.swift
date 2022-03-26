@testable import NewRelicQueryKit
import XCTest

class OffsetTests: XCTestCase {

    func testIndex() {
        let sut: Offset = .count(5)
        XCTAssertEqual(sut.stringRepresentation(), "5")
    }

}
