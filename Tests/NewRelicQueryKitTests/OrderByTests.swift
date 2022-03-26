@testable import NewRelicQueryKit
import XCTest

class OrderByTests: XCTestCase {

    func testAscending() {
        let sut: OrderBy = .attribute("name", direction: .ascending)
        XCTAssertEqual(sut.stringRepresentation(), "name ASC")
    }

    func testDescending() {
        let sut: OrderBy = .attribute("name", direction: .descending)
        XCTAssertEqual(sut.stringRepresentation(), "name DESC")
    }

}
