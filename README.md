# NewRelicQueryKit

A package for supporting NewRelic queries.

## Table of Contents
* [Overview](#Overview)
* [SELECT Clause](#SELECT)
  * [Select an attribute](#SELECT_ATTR)
  * [Select an attribute with a label](#SELECT_ATTR_LABEL)
  * [Select a function and attribute](#SELECT_FUNC)
  * [Select a function and attribute with a label](#SELECT_FUNC_WITH_LABEL)
* [FROM Clause](#FROM)
  * [Specify a data type](#FROM_DATA_TYPE)
* [FACET Clause](#FACET)
  * [Specify an attribute](#FACET_ATTR)
  * [Specify an attribute with a label](#FACET_ATTR_LABEL)
* [LIMIT Clause](#LIMIT)
  * [Specify a count](#LIMIT_COUNT)
  * [Specify the max limit](#LIMIT_MAX)
* [OFFSET Clause](#OFFSET)
  * [Specify a count](#OFFSET_COUNT)
* [ORDER BY Clause](#ORDER_BY)
  * [Specify an attribute](#ORDER_BY_ATTR)
  * [Specify an attribute and sort direction](#ORDER_BY_ATTR_DIR)
* [SINCE Clause](#SINCE)
  * [Specify the current time](#SINCE_NOW)
  * [Specify a relative day](#SINCE_DAY)
  * [Specify a relative value and unit](#SINCE_VALUE)
  * [Specify a date](#SINCE_TIMESTAMP)
* [UNTIL Clause](#UNTIL)
* [WHERE Clause](#WHERE)
  * [Use an operator](#WHERE_OPERATOR)
  * [Use a compound operator (AND and OR)](#WHERE_COMPOUND)
* [WITH TIMEZONE Clause](#WITH_TIMEZONE)
  * [Specify a timezone](#TIMEZONE_SPECIFY)

## <a name='Overview'></a>Overview

To create a query, use a `QueryBuilder` object.  Here's an Example:

```Swift
let query = QueryBuilder()
    .select("name", label: "Customer Name")
    .select("age")
    .from("Customers")
    .where(
        .or(
            .attribute("age", lessThan: 13),
            .attribute("age", greaterThan: 19)
        )
    )
    .orderBy("age", .descending)
    .since(5, .day)
    .until(.now)
    .timezone(.utc)
    .build()
```

Which generates the following query:

```SQL
SELECT name AS 'Customer Name', age FROM Customers WHERE age < 13 OR age > 19 ORDER BY age DESC SINCE 5 DAY AGO UNTIL NOW WITH TIMEZONE 'UTC'
```

To execute the query, use a `NewReliceService` object.  Here's an Example using the query from above:

```Swift
let service = NewRelicService(accountId: "XXX", queryKey: "XXX")
let results = try await service.eventsForQuery(query)
```

If you have a Decodable type for your events, you can use the `decodedEventsForQuery` method instead:

```Swift
let results: [MyEventType] = try await service.decodedEventsForQuery(query)
```

## <a name='SELECT'></a>SELECT Clause

### <a name='SELECT_ATTR'></a>Select an attribute

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .build()
```

```SQL
SELECT name FROM Customers
```

### <a name='SELECT_ATTR_LABEL'></a>Select an attribute with a label

```Swift
QueryBuilder()
    .select("name", label: "Customer Name")
    .from("Customers")
    .build()
```

```SQL
SELECT name AS 'Customer Name' FROM Customers
```

### <a name='SELECT_FUNC'></a>Select a function and attribute

```Swift
QueryBuilder()
    .selectFunction("AVG", attribute: "age")
    .from("Customers")
    .build()
```

```SQL
SELECT AVG(age) FROM Customers
```

### <a name='SELECT_FUNC_WITH_LABEL'></a>Select a function and attribute with a label

```Swift
QueryBuilder()
    .selectFunction("AVG", attribute: "age", label: "Customer Age")
    .from("Customers")
    .build()
```

```SQL
SELECT AVG(age) AS 'Customer Age' FROM Customers
```

## <a name='FROM'></a>FROM Clause

### <a name='FROM_DATA_TYPE'></a>Specify a data type

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .build()
```

```SQL
SELECT name FROM Customers
```

## <a name='FACET'></a>FACET Clause

### <a name='FACET_ATTR'></a>Specify an attribute

```Swift
QueryBuilder()
    .selectFunction("COUNT", attribute: "zipcode")
    .from("Customers")
    .facet("zipcode")
    .build()
```

```SQL
SELECT COUNT(zipcode) FROM Customers FACET zipcode
```

### <a name='FACET_ATTR_LABEL'></a>Specify an attribute with a label

```Swift
QueryBuilder()
    .selectFunction("COUNT", attribute: "zipcode")
    .from("Customers")
    .facet("zipcode", label: "Customer Zipcode")
    .build()
```

```SQL
SELECT COUNT(zipcode) FROM Customers FACET zipcode AS 'Customer Zipcode'
```

## <a name='LIMIT'></a>LIMIT Clause

### <a name='LIMIT_COUNT'></a>Specify a count

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .limit(25)
    .build()
```

```SQL
SELECT name FROM Customers LIMIT 25
```

### <a name='LIMIT_MAX'></a>Specify the max limit

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .limit(Limit.max)
    .build()
```

```SQL
SELECT name FROM Customers LIMIT MAX
```

## <a name='OFFSET'></a>OFFSET Clause

### <a name='OFFSET_COUNT'></a>Specify a count

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .limit(25)
    .offset(25)
    .build()
```

```SQL
SELECT name FROM Customers LIMIT 25 OFFSET 25
```

## <a name='ORDER_BY'></a>ORDER BY Clause

### <a name='ORDER_BY_ATTR'></a>Specify an attribute (the default sort direction is ascending)

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .orderBy("age")
    .build()
```

```SQL
SELECT name FROM Customers ORDER BY age ASC
```

### <a name='ORDER_BY_ATTR_DIR'></a>Specify an attribute and sort direction

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .orderBy("age", .descending)
    .build()
```

```SQL
SELECT name FROM Customers ORDER BY age DESC
```

## <a name='SINCE'></a>SINCE Clause

### <a name='SINCE_NOW'></a>Specify the current time

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .since(.now)
    .build()
```

```SQL
SELECT name FROM Customers SINCE NOW
```

### <a name='SINCE_DAY'></a>Specify a relative day

* today
* yesterday
* sunday
* monday
* tuesday
* wednesday
* thursday
* friday
* saturday

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .since(.thursday)
    .build()
```

```SQL
SELECT name FROM Customers SINCE THURSDAY
```

### <a name='SINCE_VALUE'></a>Specify a relative value and unit

* second
* minute
* hour
* day
* week
* month
* quarter
* year

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .since(6, .hour)
    .build()
```

```SQL
SELECT name FROM Customers SINCE 6 HOUR AGO
```

### <a name='SINCE_TIMESTAMP'></a>Specify a date

```Swift
// Sat Mar 26 19:10:37 2022 UTC
let date = Date(timeIntervalSince1970: 1648321837)

QueryBuilder()
    .select("name")
    .from("Customers")
    .since(date)
    .build()
```

```SQL
SELECT name FROM Customers SINCE '2022-03-26 19:10:37 +0000'
```

## <a name='UNTIL'></a>UNTIL Clause

Until accepts the same values as [Since](#SINCE).  Simply use `.until(...)` instead of `.since(...)`.

## <a name='WHERE'></a>WHERE Clause

### <a name='WHERE_OPERATOR'></a>Use an operator

* equalTo
* notEqualTo
* lessThan
* lessThanOrEqualTo
* greaterThan
* greaterThanOrEqualTo
* in
* notIn
* isNull
* isNotNull
* like
* notLike

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .where(.attribute("age", greaterThanOrEqualTo: 18))
    .build()
```

```SQL
SELECT name FROM Customers WHERE age >= 18
```

### <a name='WHERE_COMPOUND'></a>Use a compound operator (AND and OR)

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .where(
        .and(
          .attribute("age", greaterThanOrEqualTo: 18),
          .attributeIsNotNull("emailAddress")
        )
    )
    .build()
```

```SQL
SELECT name FROM Customers WHERE age >= 18 AND emailAddress IS NOT NULL
```

## <a name='WITH_TIMEZONE'></a>WITH TIMEZONE Clause

### <a name='TIMEZONE_SPECIFY'></a>Specify a timezone

Currently, only UTC is available.

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .timezone(.utc)
    .build()
```

```SQL
SELECT name FROM Customers WITH TIMEZONE 'UTC'
```
