import Foundation

/// Represents an NRQL OFFSET clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-offset)
public enum Offset {

    case count(Int)

}

extension Offset: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .count(count):
            return String(format: "%i", count)
        }
    }

}
