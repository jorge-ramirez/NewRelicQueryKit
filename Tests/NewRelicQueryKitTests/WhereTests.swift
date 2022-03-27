@testable import NewRelicQueryKit
import XCTest

class WhereTests: XCTestCase {

    // MARK: All Value Types

    func testIsNull() {
        let sut: Where = .attributeIsNull("age")
        XCTAssertEqual(sut.stringRepresentation(), "age IS NULL")
    }

    func testIsNotNull() {
        let sut: Where = .attributeIsNotNull("age")
        XCTAssertEqual(sut.stringRepresentation(), "age IS NOT NULL")
    }

    func testAnd() {
        let where1: Where = .attribute("age", greaterThan: 5)
        let where2: Where = .attribute("age", lessThanOrEqualTo: 15)
        let sut: Where = .and(where1, where2)
        XCTAssertEqual(sut.stringRepresentation(), "age > 5 AND age <= 15")
    }

    func testOr() {
        let where1: Where = .attribute("age", greaterThan: 5)
        let where2: Where = .attribute("age", lessThanOrEqualTo: 15)
        let sut: Where = .or(where1, where2)
        XCTAssertEqual(sut.stringRepresentation(), "age > 5 OR age <= 15")
    }

    // MARK: Int Value Types

    func testEqualInt() {
        let sut: Where = .attribute("age", equalTo: 5)
        XCTAssertEqual(sut.stringRepresentation(), "age = 5")
    }

    func testNotEqualInt() {
        let sut: Where = .attribute("age", notEqualTo: 5)
        XCTAssertEqual(sut.stringRepresentation(), "age != 5")
    }

    func testLessThanInt() {
        let sut: Where = .attribute("age", lessThan: 5)
        XCTAssertEqual(sut.stringRepresentation(), "age < 5")
    }

    func testLessThanOrEqualInt() {
        let sut: Where = .attribute("age", lessThanOrEqualTo: 5)
        XCTAssertEqual(sut.stringRepresentation(), "age <= 5")
    }

    func testGreaterThanInt() {
        let sut: Where = .attribute("age", greaterThan: 5)
        XCTAssertEqual(sut.stringRepresentation(), "age > 5")
    }

    func testGreaterThanOrEqualInt() {
        let sut: Where = .attribute("age", greaterThanOrEqualTo: 5)
        XCTAssertEqual(sut.stringRepresentation(), "age >= 5")
    }

    func testInSetInt() {
        let sut: Where = .attribute("age", in: [5, 10, 15])
        XCTAssertEqual(sut.stringRepresentation(), "age IN (5, 10, 15)")
    }

    func testNotInSetInt() {
        let sut: Where = .attribute("age", notIn: [5, 10, 15])
        XCTAssertEqual(sut.stringRepresentation(), "age NOT IN (5, 10, 15)")
    }

    // MARK: String Value Types

    func testEqualString() {
        let sut: Where = .attribute("name", equalTo: "nameValue")
        XCTAssertEqual(sut.stringRepresentation(), "name = 'nameValue'")
    }

    func testNotEqualString() {
        let sut: Where = .attribute("name", notEqualTo: "nameValue")
        XCTAssertEqual(sut.stringRepresentation(), "name != 'nameValue'")
    }

    func testInSetString() {
        let sut: Where = .attribute("name", in: ["Joe", "Mary", "Susan"])
        XCTAssertEqual(sut.stringRepresentation(), "name IN ('Joe', 'Mary', 'Susan')")
    }

    func testNotInSetString() {
        let sut: Where = .attribute("name", notIn: ["Joe", "Mary", "Susan"])
        XCTAssertEqual(sut.stringRepresentation(), "name NOT IN ('Joe', 'Mary', 'Susan')")
    }

    func testLike() {
        let sut: Where = .attribute("name", like: "%ABE%")
        XCTAssertEqual(sut.stringRepresentation(), "name LIKE '%ABE%'")
    }

    func testNotLike() {
        let sut: Where = .attribute("name", notLike: "%ABE%")
        XCTAssertEqual(sut.stringRepresentation(), "name NOT LIKE '%ABE%'")
    }

}
