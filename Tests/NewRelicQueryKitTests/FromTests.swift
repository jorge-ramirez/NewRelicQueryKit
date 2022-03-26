@testable import NewRelicQueryKit
import XCTest

class FromTests: XCTestCase {

    func testDataType() {
        let sut: From = .dataType("MobileCrash")
        XCTAssertEqual(sut.stringRepresentation(), "MobileCrash")
    }

}
