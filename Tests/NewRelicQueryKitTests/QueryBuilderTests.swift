@testable import NewRelicQueryKit
import XCTest

class QueryBuilderTests: XCTestCase {

    private var sut: QueryBuilder!

    override func setUp() {
        super.setUp()

        sut = QueryBuilder()
            .selectAttribute("name")
            .fromDataType("MobileBreadcrumb")
    }

    // MARK: SELECT

    func testSelectWildcard() {
        sut = QueryBuilder()
            .selectWildCard()
            .fromDataType("MobileBreadcrumb")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT * FROM MobileBreadcrumb")
    }

    func testSelectAttribute() {
        sut = QueryBuilder()
            .selectAttribute("name")
            .fromDataType("MobileBreadcrumb")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb")
    }

    func testSelectAttributeWithLabel() {
        sut = QueryBuilder()
            .selectAttribute("name", label: "MyName")
            .fromDataType("MobileBreadcrumb")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name AS 'MyName' FROM MobileBreadcrumb")
    }

    func testSelectFunction() {
        sut = QueryBuilder()
            .selectFunction("COUNT", attribute: "name")
            .fromDataType("MobileBreadcrumb")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT COUNT(name) FROM MobileBreadcrumb")
    }

    func testSelectFunctionWithLabel() {
        sut = QueryBuilder()
            .selectFunction("COUNT", attribute: "name", label: "MyName")
            .fromDataType("MobileBreadcrumb")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT COUNT(name) AS 'MyName' FROM MobileBreadcrumb")
    }

    // MARK: FROM

    func testFromDataType() {
        sut = QueryBuilder()
            .selectAttribute("name")
            .fromDataType("MobileBreadcrumb")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb")
    }

    // MARK: FACET

    func testFacetAttribute() {
        sut = sut.facetAttribute("name")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb FACET name")
    }

    func testFacetAttributeWithLabel() {
        sut = sut.facetAttribute("name", label: "MyName")
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb FACET name AS 'MyName'")
    }

    // MARK: LIMIT

    func testLimitCount() {
        sut = sut.limitCount(5)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb LIMIT 5")
    }

    func testLimitMax() {
        sut = sut.limitMax()
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb LIMIT MAX")
    }

    // MARK: OFFSET

    func testOffsetCount() {
        sut = sut.offsetCount(5)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb OFFSET 5")
    }

    // MARK: ORDER BY

    func testOrderByAttribute() {
        sut = sut.orderByAttribute("name", direction: .ascending)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb ORDER BY name ASC")
    }

    // MARK: SINCE

    func testSince() {
        sut = sut.since(.now)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb SINCE NOW")
    }

    // MARK: UNTIL

    func testUntilNow() {
        sut = sut.until(.now)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb UNTIL NOW")
    }

    // MARK: WHERE

    func testWhereClause() {
        sut = sut.whereClause(.isNull("name"))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb WHERE name IS NULL")
    }

    func testAnd() {
        sut = sut.and(.greaterThan("age", 5), .lessThanOrEqual("age", 15))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb WHERE age > 5 AND age <= 15")
    }

    func testOr() {
        sut = sut.or(.greaterThan("age", 5), .lessThanOrEqual("age", 15))
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb WHERE age > 5 OR age <= 15")
    }

    // MARK: WITH TIMEZONE

    func testTimezone() {
        sut = sut.timezone(.utc)
        XCTAssertEqual(sut.stringRepresentation(), "SELECT name FROM MobileBreadcrumb WITH TIMEZONE 'UTC'")
    }

}
