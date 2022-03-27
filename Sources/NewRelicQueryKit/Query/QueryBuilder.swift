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

    public func select(_ attribute: String, label: String? = nil) -> QueryBuilder {
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

    public func from(_ dataType: String) -> QueryBuilder {
        from(.dataType(dataType))
    }

    // MARK: FACET

    public func facet(_ facet: Facet) -> QueryBuilder {
        query.facets.append(facet)
        return self
    }

    public func facet(_ attribute: String, label: String? = nil) -> QueryBuilder {
        facet(.attribute(attribute, label: label))
    }

    // MARK: LIMIT

    public func limit(_ limit: Limit) -> QueryBuilder {
        query.limit = limit
        return self
    }

    public func limit(_ count: Int) -> QueryBuilder {
        limit(.count(count))
    }

    // MARK: OFFSET

    public func offset(_ offset: Offset) -> QueryBuilder {
        query.offset = offset
        return self
    }

    public func offset(_ count: Int) -> QueryBuilder {
        offset(.count(count))
    }

    // MARK: ORDER BY

    public func orderBy(_ orderBy: OrderBy) -> QueryBuilder {
        query.orderBy = orderBy
        return self
    }

    public func orderBy(_ attribute: String, _ direction: OrderBy.Direction = .ascending) -> QueryBuilder {
        orderBy(.attribute(attribute, direction: direction))
    }

    // MARK: SINCE

    public func since(_ since: Time) -> QueryBuilder {
        query.since = since
        return self
    }

    public func since(_ day: Time.Day) -> QueryBuilder {
        since(.relativeDay(day))
    }

    public func since(_ value: Int, _ unit: Time.Unit) -> QueryBuilder {
        since(.relativeValue(value, unit))
    }

    public func since(_ timestamp: Date) -> QueryBuilder {
        since(.timestamp(timestamp))
    }

    // MARK: UNTIL

    public func until(_ until: Time) -> QueryBuilder {
        query.until = until
        return self
    }

    public func until(_ day: Time.Day) -> QueryBuilder {
        until(.relativeDay(day))
    }

    public func until(_ value: Int, _ unit: Time.Unit) -> QueryBuilder {
        until(.relativeValue(value, unit))
    }

    public func until(_ timestamp: Date) -> QueryBuilder {
        until(.timestamp(timestamp))
    }

    // MARK: WHERE

    public func `where`(_ whereClause: Where) -> QueryBuilder {
        query.wheres.append(whereClause)
        return self
    }

    // MARK: WITH TIMEZONE

    public func timezone(_ timezone: Timezone) -> QueryBuilder {
        query.timezone = timezone
        return self
    }

    // MARK: Query Generation

    public func build() -> String {
        query.stringRepresentation()
    }

}

extension QueryBuilder: QueryRepresentable {

    public func stringRepresentation() -> String {
        build()
    }

}
