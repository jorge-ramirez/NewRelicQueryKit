@testable import NewRelicQueryKit
import XCTest

class WhereValueRepresentableTests: XCTestCase {

    func testInt() {
        let sut: Int = 5

        XCTAssertEqual(sut.escapedQueryValue(), "5")
    }

    func testDouble() {
        let sut: Double = 5.0

        XCTAssertEqual(sut.escapedQueryValue(), "5.0")
    }

    func testFloat() {
        let sut: Float = 5.0

        XCTAssertEqual(sut.escapedQueryValue(), "5.0")
    }

    func testString() {
        let sut: String = "5"

        XCTAssertEqual(sut.escapedQueryValue(), "'5'")
    }

}
