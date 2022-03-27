@testable import NewRelicQueryKit
import XCTest

class QueryBuilderTests: XCTestCase {

    // MARK: SELECT

    func testSelectWildcard() {
        let query = QueryBuilder()
            .select("*")
            .from("MobileBreadcrumb")
            .build()
        XCTAssertEqual(query, "SELECT * FROM MobileBreadcrumb")
    }

    func testSelectAttribute() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb")
    }

    func testSelectAttributeWithLabel() {
        let query = QueryBuilder()
            .select("name", label: "MyName")
            .from("MobileBreadcrumb")
            .build()
        XCTAssertEqual(query, "SELECT name AS 'MyName' FROM MobileBreadcrumb")
    }

    func testSelectFunction() {
        let query = QueryBuilder()
            .selectFunction("COUNT", attribute: "name")
            .from("MobileBreadcrumb")
            .build()
        XCTAssertEqual(query, "SELECT COUNT(name) FROM MobileBreadcrumb")
    }

    func testSelectFunctionWithLabel() {
        let query = QueryBuilder()
            .selectFunction("COUNT", attribute: "name", label: "MyName")
            .from("MobileBreadcrumb")
            .build()
        XCTAssertEqual(query, "SELECT COUNT(name) AS 'MyName' FROM MobileBreadcrumb")
    }

    // MARK: FROM

    func testFromDataType() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb")
    }

    // MARK: FACET

    func testFacetAttribute() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .facet("name")
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb FACET name")
    }

    func testFacetAttributeWithLabel() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .facet("name", label: "MyName")
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb FACET name AS 'MyName'")
    }

    // MARK: LIMIT

    func testLimitCount() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .limit(5)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb LIMIT 5")
    }

    func testLimitMax() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .limit(Limit.max)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb LIMIT MAX")
    }

    // MARK: OFFSET

    func testOffsetCount() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .offset(5)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb OFFSET 5")
    }

    // MARK: ORDER BY

    func testOrderByAttribute() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .orderBy("name", .ascending)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb ORDER BY name ASC")
    }

    // MARK: SINCE

    func testSince() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .since(Time.now)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb SINCE NOW")
    }

    func testSinceRelativeDay() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .since(.saturday)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb SINCE SATURDAY")
    }

    func testSinceRelativeValue() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .since(5, .day)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb SINCE 5 DAY AGO")
    }

    func testSinceTimestamp() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .since(Date(timeIntervalSince1970: 1648321837)) // Sat Mar 26 19:10:37 2022 UTC
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb SINCE '2022-03-26 19:10:37 +0000'")
    }

    // MARK: UNTIL

    func testUntilNow() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .until(Time.now)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb UNTIL NOW")
    }

    func testUntilRelativeDay() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .until(.saturday)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb UNTIL SATURDAY")
    }

    func testUntilRelativeValue() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .until(5, .day)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb UNTIL 5 DAY AGO")
    }

    func testUntilTimestamp() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .until(Date(timeIntervalSince1970: 1648321837)) // Sat Mar 26 19:10:37 2022 UTC
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb UNTIL '2022-03-26 19:10:37 +0000'")
    }

    // MARK: WHERE

    func testWhere() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .where(.attributeIsNull("name"))
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb WHERE name IS NULL")
    }

    func testAnd() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .where(
                .and(
                    .attribute("age", greaterThan: 5),
                    .attribute("age", lessThanOrEqualTo: 15)
                )
            )
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb WHERE age > 5 AND age <= 15")
    }

    func testOr() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .where(
                .or(
                    .attribute("age", greaterThan: 5),
                    .attribute("age", lessThanOrEqualTo: 15)
                )
            )
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb WHERE age > 5 OR age <= 15")
    }

    // MARK: WITH TIMEZONE

    func testTimezone() {
        let query = QueryBuilder()
            .select("name")
            .from("MobileBreadcrumb")
            .timezone(.utc)
            .build()
        XCTAssertEqual(query, "SELECT name FROM MobileBreadcrumb WITH TIMEZONE 'UTC'")
    }

}
