import Foundation

/// Represents an NRQL WHERE clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-where)
public enum Where {

    case equal(String, WhereValueRepresentable)
    case notEqual(String, WhereValueRepresentable)
    case lessThan(String, WhereValueRepresentable)
    case lessThanOrEqual(String, WhereValueRepresentable)
    case greaterThan(String, WhereValueRepresentable)
    case greaterThanOrEqual(String, WhereValueRepresentable)

    case inSet(String, [WhereValueRepresentable])
    case notInSet(String, [WhereValueRepresentable])

    case isNull(String)
    case isNotNull(String)

    case like(String, String)
    case notLike(String, String)

    indirect case and(Where, Where)
    indirect case or(Where, Where)

}

extension Where: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .equal(name, value):
            return String(format: "%@ = %@", name, value.escapedQueryValue())
        case let .notEqual(name, value):
            return String(format: "%@ != %@", name, value.escapedQueryValue())
        case let .lessThan(name, value):
            return String(format: "%@ < %@", name, value.escapedQueryValue())
        case let .lessThanOrEqual(name, value):
            return String(format: "%@ <= %@", name, value.escapedQueryValue())
        case let .greaterThan(name, value):
            return String(format: "%@ > %@", name, value.escapedQueryValue())
        case let .greaterThanOrEqual(name, value):
            return String(format: "%@ >= %@", name, value.escapedQueryValue())

        case let .inSet(name, value):
            return String(format: "%@ IN (%@)", name, value.escapedQueryValue())
        case let .notInSet(name, value):
            return String(format: "%@ NOT IN (%@)", name, value.escapedQueryValue())

        case let .isNull(name):
            return String(format: "%@ IS NULL", name)
        case let .isNotNull(name):
            return String(format: "%@ IS NOT NULL", name)

        case let .like(name, format):
            return String(format: "%@ LIKE '%@'", name, format)
        case let .notLike(name, format):
            return String(format: "%@ NOT LIKE '%@'", name, format)

        case let .and(where1, where2):
            return String(format: "%@ AND %@", where1.stringRepresentation(), where2.stringRepresentation())
        case let .or(where1, where2):
            return String(format: "%@ OR %@", where1.stringRepresentation(), where2.stringRepresentation())
        }
    }

}
