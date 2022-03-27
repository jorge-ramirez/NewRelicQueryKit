import Foundation

/// Represents an NRQL TIME value, used with the SINCE and UNTIL clauses.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-since)
public enum Time {

    public enum Day: String {
        case today
        case yesterday

        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }

    public enum Unit: String {
        case year
        case quarter
        case month
        case week
        case day
        case hour
        case minute
        case second
    }

    case now
    case relativeDay(Day)
    case relativeValue(Int, Unit)
    case timestamp(Date)

    // MARK: Private Properties

    private static let dateFormatter: DateFormatter = Self.createDateFormatter()

    // MARK: Private Methods

    private static func createDateFormatter() -> DateFormatter {
        guard let timezone = Foundation.TimeZone(secondsFromGMT: 0) else {
            preconditionFailure("Could not create UTC timezone.")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        dateFormatter.timeZone = timezone

        return dateFormatter
    }

}

extension Time: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case .now:
            return "NOW"
        case let .relativeDay(day):
            return day.rawValue.uppercased()
        case let .relativeValue(value, unit):
            return String(format: "%i %@ AGO", value, unit.rawValue.uppercased())
        case let .timestamp(date):
            return String(format: "'%@'", Self.dateFormatter.string(from: date))
        }
    }

}
