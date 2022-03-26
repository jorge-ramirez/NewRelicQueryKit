import Foundation

/// Represents an NRQL FROM clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-from)
public enum From {

    case dataType(String)

}

extension From: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .dataType(dataType):
            return dataType
        }
    }

}
