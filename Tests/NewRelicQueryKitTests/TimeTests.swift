@testable import NewRelicQueryKit
import XCTest

class TimeTests: XCTestCase {

    func testNow() {
        let sut: Time = .now
        XCTAssertEqual(sut.stringRepresentation(), "NOW")
    }

    func testDay() {
        let timeAndExpectedValues: [(Time, String)] = [
            (.relativeDay(.yesterday), "YESTERDAY"),
            (.relativeDay(.today), "TODAY"),

            (.relativeDay(.sunday), "SUNDAY"),
            (.relativeDay(.monday), "MONDAY"),
            (.relativeDay(.tuesday), "TUESDAY"),
            (.relativeDay(.wednesday), "WEDNESDAY"),
            (.relativeDay(.thursday), "THURSDAY"),
            (.relativeDay(.friday), "FRIDAY"),
            (.relativeDay(.saturday), "SATURDAY")
        ]

        for (sut, expetedValue) in timeAndExpectedValues {
            XCTAssertEqual(sut.stringRepresentation(), expetedValue)
        }
    }

    func testRelative() {
        let timeAndExpectedValues: [(Time, String)] = [
            (.relativeValue(5, .second), "5 SECOND AGO"),
            (.relativeValue(5, .minute), "5 MINUTE AGO"),
            (.relativeValue(5, .hour), "5 HOUR AGO"),
            (.relativeValue(5, .day), "5 DAY AGO"),
            (.relativeValue(5, .week), "5 WEEK AGO"),
            (.relativeValue(5, .month), "5 MONTH AGO"),
            (.relativeValue(5, .quarter), "5 QUARTER AGO"),
            (.relativeValue(5, .year), "5 YEAR AGO")
        ]

        for (sut, expetedValue) in timeAndExpectedValues {
            XCTAssertEqual(sut.stringRepresentation(), expetedValue)
        }
    }

    func testTimestamp() {
        let sut: Time = .timestamp(Date(timeIntervalSince1970: 1648321837)) // Sat Mar 26 19:10:37 2022 UTC
        XCTAssertEqual(sut.stringRepresentation(), "'2022-03-26 19:10:37 +0000'")
    }

}
