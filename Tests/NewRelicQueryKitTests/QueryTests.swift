@testable import NewRelicQueryKit
import XCTest

class QueryTests: XCTestCase {

    private var sut: Query!

    override func setUp() {
        super.setUp()

        sut = Query()
        sut.selects.append(.attribute("name"))
        sut.froms.append(.dataType("MobileBreadcrumb"))
    }

    // MARK: SELECT

    func testSelect() {
        sut = Query()
        sut.selects.append(.attribute("name"))
        sut.froms.append(.dataType("MobileBreadcrumb"))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb")
    }

    func testFrom() {
        sut = Query()
        sut.selects.append(.attribute("name"))
        sut.froms.append(.dataType("MobileBreadcrumb"))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb")
    }

    func testFacet() {
        sut.facets.append(.attribute("name"))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb FACET name")
    }

    func testLimit() {
        sut.limit = .count(5)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb LIMIT 5")
    }

    func testOffset() {
        sut.offset = .count(5)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb OFFSET 5")
    }

    func testOrderBy() {
        sut.orderBy = .attribute("name", direction: .ascending)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb ORDER BY name ASC")
    }

    func testSince() {
        sut.since = .now
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb SINCE NOW")
    }

    func testUntil() {
        sut.until = .now
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb UNTIL NOW")
    }

    func testWhere() {
        sut.wheres.append(.attributeIsNull("name"))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb WHERE name IS NULL")
    }

    func testTimezone() {
        sut.timezone = .utc
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb WITH TIMEZONE 'UTC'")
    }

}
