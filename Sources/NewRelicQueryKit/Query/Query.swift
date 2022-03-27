import Foundation

/// Represents an NRQL Query.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/)
public class Query {

    internal var selects: [Select]
    internal var froms: [From]
    internal var facets: [Facet]
    internal var limit: Limit?
    internal var offset: Offset?
    internal var orderBy: OrderBy?
    internal var since: Time?
    internal var until: Time?
    internal var wheres: [Where]
    internal var timezone: Timezone?

    internal init() {
        self.selects = []
        self.froms = []
        self.facets = []
        self.limit = nil
        self.offset = nil
        self.orderBy = nil
        self.since = nil
        self.until = nil
        self.wheres = []
        self.timezone = nil
    }

    // MARK: Internal Methods

    internal func stringRepresentation() -> String {
        let queryClauses: [String?] = [
            buildSelectClause(),
            buildFromClause(),
            buildFacetClause(),
            buildLimitClause(),
            buildOffsetClause(),
            buildWhereClause(),
            buildOrderByClause(),
            buildSinceClause(),
            buildUntilClause(),
            buildTimezoneClause()
        ]

        return queryClauses.compactMap { $0 }.joined(separator: " ")
    }

    // MARK: Private Methods

    private func buildSelectClause() -> String {
        let values = selects.map { $0.stringRepresentation() }.joined(separator: ", ")
        return String(format: "SELECT %@", values)
    }

    private func buildFromClause() -> String {
        let values = froms.map { $0.stringRepresentation() }.joined(separator: ", ")
        return String(format: "FROM %@", values)
    }

    private func buildFacetClause() -> String? {
        guard !facets.isEmpty else {
            return nil
        }

        let values = facets.map { $0.stringRepresentation() }.joined(separator: ", ")
        return String(format: "FACET %@", values)
    }

    private func buildLimitClause() -> String? {
        guard let limit = limit else {
            return nil
        }

        return String(format: "LIMIT %@", limit.stringRepresentation())
    }

    private func buildOffsetClause() -> String? {
        guard let offset = offset else {
            return nil
        }

        return String(format: "OFFSET %@", offset.stringRepresentation())
    }

    private func buildWhereClause() -> String? {
        guard !wheres.isEmpty else {
            return nil
        }

        let values = wheres.map { $0.stringRepresentation() }.joined(separator: ", ")
        return String(format: "WHERE %@", values)
    }

    private func buildOrderByClause() -> String? {
        guard let orderBy = orderBy else {
            return nil
        }

        return String(format: "ORDER BY %@", orderBy.stringRepresentation())
    }

    private func buildSinceClause() -> String? {
        guard let since = since else {
            return nil
        }

        return String(format: "SINCE %@", since.stringRepresentation())
    }

    private func buildUntilClause() -> String? {
        guard let until = until else {
            return nil
        }

        return String(format: "UNTIL %@", until.stringRepresentation())
    }

    private func buildTimezoneClause() -> String? {
        guard let timezone = timezone else {
            return nil
        }

        return String(format: "WITH TIMEZONE %@", timezone.stringRepresentation())
    }

}
