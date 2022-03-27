import Foundation

/// Represents an NRQL FACET clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-facet)
public enum Facet {

    case attribute(String, label: String? = nil)

}

extension Facet: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .attribute(attr, label):
            if let label = label {
                return String(format: "%@ AS '%@'", attr, label)
            }

            return attr
        }
    }

}
