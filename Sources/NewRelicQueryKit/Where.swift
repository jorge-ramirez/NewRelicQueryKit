import Foundation

/// Represents an NRQL WHERE clause.
/// [New Relic Documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/#sel-where)
public enum Where {

    public enum Operator: String {
        case equals = "="
        case notEquals = "!="
        case lessThan = "<"
        case lessThanOrEqualTo = "<="
        case greaterThan = ">"
        case greaterThanOrEqualTo = ">="

        case inSet = "IN"
        case notInSet = "NOT IN"

        case isNull = "IS NULL"
        case isNotNull = "IS NOT NULL"

        case like = "LIKE"
        case notLike = "NOT LIKE"
    }

    case clause(_ attribute: String, `operator`: Operator, value: WhereValueRepresentable)
    indirect case and(Where, Where)
    indirect case or(Where, Where)

    static func attribute(_ attribute: String, equalTo value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .equals, value: value)
    }

    static func attribute(_ attribute: String, notEqualTo value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .notEquals, value: value)
    }

    static func attribute(_ attribute: String, lessThan value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .lessThan, value: value)
    }

    static func attribute(_ attribute: String, lessThanOrEqualTo value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .lessThanOrEqualTo, value: value)
    }

    static func attribute(_ attribute: String, greaterThan value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .greaterThan, value: value)
    }

    static func attribute(_ attribute: String, greaterThanOrEqualTo value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .greaterThanOrEqualTo, value: value)
    }

    static func attribute(_ attribute: String, in value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .inSet, value: value)
    }

    static func attribute(_ attribute: String, notIn value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .notInSet, value: value)
    }

    static func attributeIsNull(_ attribute: String) -> Where {
        .clause(attribute, operator: .isNull, value: "")
    }

    static func attributeIsNotNull(_ attribute: String) -> Where {
        .clause(attribute, operator: .isNotNull, value: "")
    }

    static func attribute(_ attribute: String, like value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .like, value: value)
    }

    static func attribute(_ attribute: String, notLike value: WhereValueRepresentable) -> Where {
        .clause(attribute, operator: .notLike, value: value)
    }

}

extension Where: QueryRepresentable {

    internal func stringRepresentation() -> String {
        switch self {
        case let .clause(attribute, `operator`, value):
            switch `operator` {
            case .isNull, .isNotNull:
                return String(format: "%@ %@", attribute, `operator`.rawValue)
            case .inSet, .notInSet:
                return String(format: "%@ %@ (%@)", attribute, `operator`.rawValue, value.escapedQueryValue())
            default:
                return String(format: "%@ %@ %@", attribute, `operator`.rawValue, value.escapedQueryValue())
            }
        case let .and(where1, where2):
            return String(format: "%@ AND %@", where1.stringRepresentation(), where2.stringRepresentation())
        case let .or(where1, where2):
            return String(format: "%@ OR %@", where1.stringRepresentation(), where2.stringRepresentation())
        }
    }

}
