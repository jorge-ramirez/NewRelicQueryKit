import Foundation

/// Responsible for creating a Query object and its query representation.
public class QueryBuilder {

    // MARK: Private Properties

    private let query: Query

    // MARK: Initialization

    public init() {
        self.query = Query()
    }

    // MARK: SELECT

    public func select(_ select: Select) -> QueryBuilder {
        query.selects.append(select)
        return self
    }

    public func selectWildCard() -> QueryBuilder {
        select(.wildcard)
    }

    public func selectAttribute(_ attribute: String, label: String? = nil) -> QueryBuilder {
        select(.attribute(attribute, label: label))
    }

    public func selectFunction(_ function: String, attribute: String, label: String? = nil) -> QueryBuilder {
        select(.function(function, attribute: attribute, label: label))
    }

    // MARK: FROM

    public func from(_ from: From) -> QueryBuilder {
        query.froms.append(from)
        return self
    }

    public func fromDataType(_ dataType: String) -> QueryBuilder {
        from(.dataType(dataType))
    }

    // MARK: FACET

    public func facet(_ facet: Facet) -> QueryBuilder {
        query.facets.append(facet)
        return self
    }

    public func facetAttribute(_ attribute: String, label: String? = nil) -> QueryBuilder {
        facet(.attribute(attribute, label: label))
    }

    // MARK: LIMIT

    public func limit(_ limit: Limit) -> QueryBuilder {
        query.limit = limit
        return self
    }

    public func limitCount(_ count: Int) -> QueryBuilder {
        limit(.count(count))
    }

    public func limitMax() -> QueryBuilder {
        limit(.max)
    }

    // MARK: OFFSET

    public func offset(_ offset: Offset) -> QueryBuilder {
        query.offset = offset
        return self
    }

    public func offsetCount(_ count: Int) -> QueryBuilder {
        offset(.count(count))
    }

    // MARK: ORDER BY

    public func orderBy(_ orderBy: OrderBy) -> QueryBuilder {
        query.orderBys.append(orderBy)
        return self
    }

    public func orderByAttribute(_ attribute: String, direction: OrderBy.Direction = .ascending) -> QueryBuilder {
        return orderBy(.attribute(attribute, direction: direction))
    }

    // MARK: SINCE

    public func since(_ since: Time) -> QueryBuilder {
        query.since = since
        return self
    }

    // MARK: UNTIL

    public func until(_ until: Time) -> QueryBuilder {
        query.until = until
        return self
    }

    // MARK: WHERE

    public func whereClause(_ whereClause: Where) -> QueryBuilder {
        query.wheres.append(whereClause)
        return self
    }

    public func and(_ where1: Where, _ where2: Where) -> QueryBuilder {
        whereClause(.and(where1, where2))
    }

    public func or(_ where1: Where, _ where2: Where) -> QueryBuilder {
        whereClause(.or(where1, where2))
    }

    // MARK: WITH TIMEZONE

    public func timezone(_ timezone: Timezone) -> QueryBuilder {
        query.timezone = timezone
        return self
    }

}

extension QueryBuilder: QueryRepresentable {

    public func stringRepresentation() -> String {
        query.stringRepresentation()
    }

}
