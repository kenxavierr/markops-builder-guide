# Query Builders Guide

This guide is meant for people working mostly with data preparation, segmentation, query logic, and Data Extension population.

## SQL fundamentals

### Basic select

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  LastName
FROM ent.CustomerMaster
```

### WHERE filter

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE IsActive = 1
  AND Country = 'Singapore'
```

### JOIN example

```sql
SELECT
  c.SubscriberKey,
  c.EmailAddress,
  c.FirstName,
  o.OrderID,
  o.TotalAmount
FROM ent.CustomerMaster c
LEFT JOIN ent.CustomerOrders o
  ON c.SubscriberKey = o.SubscriberKey
```

### UNION example

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  Country
FROM ent.Customers_Singapore

UNION ALL

SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  Country
FROM ent.Customers_Malaysia
```

### Target audience example

```sql
SELECT
  c.SubscriberKey,
  c.EmailAddress,
  c.FirstName,
  c.Country
INTO ent.Malaysia_Active_Customers
FROM ent.CustomerMaster c
WHERE c.IsActive = 1
  AND c.Country = 'Malaysia'
```

## Best practices

- Check exact DE schema before query execution
- Filter early to reduce query load
- Validate null and missing values
- Prefer `UNION ALL` for speed and simplicity
- Use descriptive target DE names
