@testable import NewRelicQueryKit
import XCTest

class FacetTests: XCTestCase {

    func testAttributeWithNoLabel() {
        let sut: Facet = .attribute("name")
        XCTAssertEqual(sut.stringRepresentation(), "name")
    }

    func testAttributeWithLabel() {
        let sut: Facet = .attribute("name", label: "MyName")
        XCTAssertEqual(sut.stringRepresentation(), "name AS 'MyName'")
    }

}
