import Foundation

/// Represents an NRQL ORDER BY clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-order-by)
public enum OrderBy {

    public enum Direction: String {
        case ascending = "ASC"
        case descending = "DESC"
    }

    case attribute(String, direction: Direction = .ascending)

}

extension OrderBy: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .attribute(name, direction):
            return String(format: "%@ %@", name, direction.rawValue)
        }
    }

}
