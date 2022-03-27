# NewRelicQueryKit

A package for supporting NewRelic queries.

## Table of Contents
* [Overview](#Overview)
* [SELECT](#SELECT)
* [FROM](#FROM)
* [FACET](#FACET)
* [LIMIT](#LIMIT)
* [OFFSET](#OFFSET)
* [WHERE](#WHERE)
* [ORDER BY](#ORDER_BY)
* [SINCE](#SINCE)
* [UNTIL](#UNTIL)
* [WITH TIMEZONE](#WITH_TIMEZONE)

## <a name='Overview'></a>Overview

To create a query, use a `QueryBuilder`.  Here's an Example:

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

## <a name='SELECT'></a>SELECT

Select an attribute

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .build()
```

```SQL
SELECT name FROM Customers
```

Select an attribute with a label

```Swift
QueryBuilder()
    .select("name", label: "Customer Name")
    .from("Customers")
    .build()
```

```SQL
SELECT name AS 'Customer Name' FROM Customers
```

Select a function and attribute

```Swift
QueryBuilder()
    .selectFunction("AVG", attribute: "age")
    .from("Customers")
    .build()
```

```SQL
SELECT AVG(age) FROM Customers
```

Select a function and attribute with a label

```Swift
QueryBuilder()
    .selectFunction("AVG", attribute: "age", label: "Customer Age")
    .from("Customers")
    .build()
```

```SQL
SELECT AVG(age) AS 'Customer Age' FROM Customers
```

## <a name='FROM'></a>FROM

Select a data type

```Swift
QueryBuilder()
    .select("name")
    .from("Customers")
    .build()
```

```SQL
SELECT name FROM Customers
```

## <a name='FACET'></a>FACET
## <a name='LIMIT'></a>LIMIT
## <a name='OFFSET'></a>OFFSET
## <a name='WHERE'></a>WHERE
## <a name='ORDER_BY'></a>ORDER BY
## <a name='SINCE'></a>SINCE
## <a name='UNTIL'></a>UNTIL
## <a name='WITH_TIMEZONE'></a>WITH TIMEZONE
