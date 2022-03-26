@testable import NewRelicQueryKit
import XCTest

class WhereTests: XCTestCase {

    // MARK: All Value Types

    func testIsNull() {
        let sut: Where = .isNull("age")
        XCTAssertEqual(sut.stringRepresentation(), "age IS NULL")
    }

    func testIsNotNull() {
        let sut: Where = .isNotNull("age")
        XCTAssertEqual(sut.stringRepresentation(), "age IS NOT NULL")
    }

    func testAnd() {
        let where1: Where = .greaterThan("age", 5)
        let where2: Where = .lessThanOrEqual("age", 15)
        let sut: Where = .and(where1, where2)
        XCTAssertEqual(sut.stringRepresentation(), "age > 5 AND age <= 15")
    }

    func testOr() {
        let where1: Where = .greaterThan("age", 5)
        let where2: Where = .lessThanOrEqual("age", 15)
        let sut: Where = .or(where1, where2)
        XCTAssertEqual(sut.stringRepresentation(), "age > 5 OR age <= 15")
    }

    // MARK: Int Value Types

    func testEqualInt() {
        let sut: Where = .equal("age", 5)
        XCTAssertEqual(sut.stringRepresentation(), "age = 5")
    }

    func testNotEqualInt() {
        let sut: Where = .notEqual("age", 5)
        XCTAssertEqual(sut.stringRepresentation(), "age != 5")
    }

    func testLessThanInt() {
        let sut: Where = .lessThan("age", 5)
        XCTAssertEqual(sut.stringRepresentation(), "age < 5")
    }

    func testLessThanOrEqualInt() {
        let sut: Where = .lessThanOrEqual("age", 5)
        XCTAssertEqual(sut.stringRepresentation(), "age <= 5")
    }

    func testGreaterThanInt() {
        let sut: Where = .greaterThan("age", 5)
        XCTAssertEqual(sut.stringRepresentation(), "age > 5")
    }

    func testGreaterThanOrEqualInt() {
        let sut: Where = .greaterThanOrEqual("age", 5)
        XCTAssertEqual(sut.stringRepresentation(), "age >= 5")
    }

    func testInSetInt() {
        let sut: Where = .inSet("age", [5, 10, 15])
        XCTAssertEqual(sut.stringRepresentation(), "age IN (5, 10, 15)")
    }

    func testNotInSetInt() {
        let sut: Where = .notInSet("age", [5, 10, 15])
        XCTAssertEqual(sut.stringRepresentation(), "age NOT IN (5, 10, 15)")
    }

    // MARK: String Value Types

    func testEqualString() {
        let sut: Where = .equal("name", "nameValue")
        XCTAssertEqual(sut.stringRepresentation(), "name = 'nameValue'")
    }

    func testNotEqualString() {
        let sut: Where = .notEqual("name", "nameValue")
        XCTAssertEqual(sut.stringRepresentation(), "name != 'nameValue'")
    }

    func testInSetString() {
        let sut: Where = .inSet("name", ["Joe", "Mary", "Susan"])
        XCTAssertEqual(sut.stringRepresentation(), "name IN ('Joe', 'Mary', 'Susan')")
    }

    func testNotInSetString() {
        let sut: Where = .notInSet("name", ["Joe", "Mary", "Susan"])
        XCTAssertEqual(sut.stringRepresentation(), "name NOT IN ('Joe', 'Mary', 'Susan')")
    }

    func testLike() {
        let sut: Where = .like("name", "%ABE%")
        XCTAssertEqual(sut.stringRepresentation(), "name LIKE '%ABE%'")
    }

    func testNotLike() {
        let sut: Where = .notLike("name", "%ABE%")
        XCTAssertEqual(sut.stringRepresentation(), "name NOT LIKE '%ABE%'")
    }

}
