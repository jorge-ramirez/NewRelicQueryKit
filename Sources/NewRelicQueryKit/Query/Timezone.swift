import Foundation

/// Represents an NRQL WITH TIMEZONE clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-timezone)
public enum Timezone: String {

    case utc = "UTC"

}

extension Timezone: QueryRepresentable {

    internal func stringRepresentation() -> String {
        return String(format: "'%@'", self.rawValue)
    }

}
