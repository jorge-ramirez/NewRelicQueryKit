@testable import NewRelicQueryKit
import XCTest

class TimezoneTests: XCTestCase {

    func testTimezones() {
        let timezonesAndExpectedValues: [(Timezone, String)] = [
            (.utc, "'UTC'")
        ]

        for (sut, expetedValue) in timezonesAndExpectedValues {
            XCTAssertEqual(sut.stringRepresentation(), expetedValue)
        }
    }

}
