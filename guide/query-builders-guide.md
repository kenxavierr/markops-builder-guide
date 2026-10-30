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

## Utility queries

These are helpful when you want quick checks on status counts, record volume, and duplicate cleanup before creating a final audience or DE population query.

### 1) Status count check

```sql
SELECT
  a.Status,
  COUNT(*) AS Cnt
FROM DEName a
WHERE a.Status IN ('Active', 'Cancelled')
GROUP BY a.Status
```

### 2) Campaign-level status volume

```sql
SELECT
  a.CampaignCode__c,
  a.Status,
  COUNT(*) AS Cnt
FROM ent.Salesforce_Sample a
WHERE a.CampaignCode__c = '000000123'
  AND a.Status IN ('Active', 'Cancelled')
GROUP BY
  a.CampaignCode__c,
  a.Status
```

### 3) Total record volume by status

```sql
SELECT
  a.Status,
  COUNT(*) AS TotalVolume
FROM ent.Salesforce_Sample a
GROUP BY a.Status
ORDER BY TotalVolume DESC
```

### 4) Volume by campaign code

```sql
SELECT
  a.CampaignCode__c,
  COUNT(*) AS TotalRecords
FROM ent.Salesforce_Sample a
GROUP BY a.CampaignCode__c
ORDER BY TotalRecords DESC
```

### 5) Deduplicate records and keep the latest row per key

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  Country
FROM (
  SELECT
    SubscriberKey,
    EmailAddress,
    FirstName,
    Country,
    ROW_NUMBER() OVER (
      PARTITION BY SubscriberKey
      ORDER BY CreatedDate DESC
    ) AS rn
  FROM ent.CustomerMaster
) x
WHERE x.rn = 1
```

This pattern keeps one record per `SubscriberKey` and is especially useful when a DE has multiple rows for the same contact.

## Best practices

- Check exact DE schema before query execution
- Filter early to reduce query load
- Validate null and missing values
- Prefer `UNION ALL` for speed and simplicity
- Use descriptive target DE names
