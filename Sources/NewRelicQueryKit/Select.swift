import Foundation

/// Represents an NRQL SELECT clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#state-select)
public enum Select {

    case attribute(String, label: String? = nil)
    case function(String, attribute: String, label: String? = nil)

}

extension Select: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .attribute(attr, label):
            if let label = label {
                return String(format: "%@ AS '%@'", attr, label)
            }

            return attr
        case let .function(funcName, attr, label):
            if let label = label {
                return String(format: "%@(%@) AS '%@'", funcName, attr, label)
            }

            return String(format: "%@(%@)", funcName, attr)
        }
    }

}
