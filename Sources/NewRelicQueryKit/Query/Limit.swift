import Foundation

/// Represents an NRQL LIMIT clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-limit)
public enum Limit {

    case count(Int)
    case max

}

extension Limit: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .count(count):
            return String(format: "%i", count)
        case .max:
            return "MAX"
        }
    }

}
