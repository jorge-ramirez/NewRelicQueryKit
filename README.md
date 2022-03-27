# NewRelicQueryKit

A package for supporting NewRelic queries.

## Creating Queries

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

## SELECT

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

## FROM

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

## FACET
