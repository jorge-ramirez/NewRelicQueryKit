@testable import NewRelicQueryKit
import XCTest

class SelectTests: XCTestCase {

    func testAttributeWithNoLabel() {
        let sut: Select = .attribute("name")
        XCTAssertEqual(sut.stringRepresentation(), "name")
    }

    func testAttributeWithLabel() {
        let sut: Select = .attribute("name", label: "MyName")
        XCTAssertEqual(sut.stringRepresentation(), "name AS 'MyName'")
    }

    func testFunctionWithNoLabel() {
        let sut: Select = .function("COUNT", attribute: "name")
        XCTAssertEqual(sut.stringRepresentation(), "COUNT(name)")
    }

    func testFunctionWithLabel() {
        let sut: Select = .function("COUNT", attribute: "name", label: "MyName")
        XCTAssertEqual(sut.stringRepresentation(), "COUNT(name) AS 'MyName'")
    }

}
