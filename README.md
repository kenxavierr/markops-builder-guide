# MarkOps Builder Guide

A beginner-friendly SFMC guide for marketers and campaign builders working with AMPscript and SQL.

This repository is designed as a practical starter kit for:
- marketers creating dynamic email content
- campaign builders using Data Extensions
- teams who need fast, readable examples
- beginners learning SFMC logic without deep developer setup

## Contents

- [Overview](#overview)
- [AMPscript Fundamentals](#ampscript-fundamentals)
  - [Variable initialization](#variable-initialization)
  - [Reading values from a Data Extension](#reading-values-from-a-data-extension)
  - [Personalization in the email body](#personalization-in-the-email-body)
  - [IF / ELSEIF / ELSE logic](#if--elseif--else-logic)
  - [FOR loops](#for-loops)
  - [Best practices](#best-practices)
- [SQL Fundamentals](#sql-fundamentals)
  - [SELECT from a DE](#select-from-a-data-extension)
  - [WHERE filters](#where-filters)
  - [JOIN basics](#join-basics)
  - [UNION basics](#union-basics)
  - [ORDER BY and LIMIT](#order-by-and-limit)
  - [Best practices](#sql-best-practices)
- [Common beginner workflows](#common-beginner-workflows)
- [Copy-paste snippets](#copy-paste-snippets)
- [Additional guides](#additional-guides)

## Overview

Salesforce Marketing Cloud (SFMC) helps teams build personalized customer journeys, dynamic emails, and campaign data workflows.

For marketers, two core skills matter most:
- AMPscript for dynamic content in emails, CloudPages, and snippets
- SQL for filtering, segmenting, and preparing data in Data Extensions

This guide focuses on real-world beginner use cases and keeps examples simple enough to use immediately.

---

## AMPscript Fundamentals

### Variable initialization

Use variables to store values that you can reuse later.

```ampscript
%%[
  var @firstName, @city, @offerText

  set @firstName = "Sarah"
  set @city = "Singapore"
  set @offerText = "Free Shipping"
]%%
```

### Reading values from a Data Extension

```ampscript
%%[
  var @SubscriberKey, @FirstName

  set @SubscriberKey = AttributeValue("SubscriberKey")
  set @FirstName = Lookup("ENT.CustomerMaster","FirstName","SubscriberKey",@SubscriberKey)
]%%

Hi %%=v(@FirstName)=%%,
```

### Personalization in the email body

```ampscript
%%[
  var @firstName, @lastName, @city

  set @firstName = "Alicia"
  set @lastName = "Tan"
  set @city = "Kuala Lumpur"
]%%

Hi %%=v(@firstName)=%% %%=v(@lastName)=%%,

We have a special offer for customers in %%=v(@city)=%%.
```

### IF / ELSEIF / ELSE logic

```ampscript
%%[
  var @customerTier
  set @customerTier = "Silver"
]%%

%%[ if @customerTier == "Gold" then ]%%
  Gold member pricing is active.
%%[ elseif @customerTier == "Silver" then ]%%
  Silver member pricing is active.
%%[ elseif @customerTier == "Bronze" then ]%%
  Bronze member pricing is active.
%%[ else ]%%
  Standard pricing applies.
%%[ endif ]%%
```

### FOR loops

```ampscript
%%[
  var @i

  for @i = 1 to 3 do
]%%
  Item %%=v(@i)=%%<br>
%%[
  next @i
]%%
```

### Best practices

- Use clear variable names like `@firstName`, not `@x`
- Keep logic readable and simple
- Validate values before output
- Test in preview mode before sending
- Comment sections when logic gets longer

---

## SQL Fundamentals

### Select from a Data Extension

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  LastName
FROM ent.CustomerMaster
```

### WHERE filters

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE IsActive = 1
  AND Country = 'Malaysia'
```

### JOIN basics

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

### UNION basics

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

### ORDER BY and LIMIT

```sql
SELECT TOP 100
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE IsActive = 1
ORDER BY FirstName ASC
```

### SQL best practices

- Check exact DE field names before running a query
- Use `WHERE` early to reduce data volume
- Prefer `UNION ALL` if duplicates are acceptable
- Use aliases to keep queries readable
- Test on a small sample before writing large audience sets

---

## Common beginner workflows

### Dynamic greeting by first name

```ampscript
%%[
  var @firstName
  set @firstName = Lookup("ENT.CustomerMaster","FirstName","SubscriberKey",AttributeValue("SubscriberKey"))
]%%

Hi %%=v(@firstName)=%%,
```

### Personalized offer based on customer tier

```ampscript
%%[
  var @customerTier, @offerText

  set @customerTier = Lookup("ENT.CustomerMaster","CustomerTier","SubscriberKey",AttributeValue("SubscriberKey"))

  if @customerTier == "Gold" then
    set @offerText = "Enjoy a 20% Gold member offer."
  elseif @customerTier == "Silver" then
    set @offerText = "Enjoy a 10% Silver member offer."
  else
    set @offerText = "Explore our latest offers."
  endif
]%%

<p>%%=v(@offerText)=%%</p>
```

### Target active Malaysia customers

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  Country
FROM ent.CustomerMaster
WHERE IsActive = 1
  AND Country = 'Malaysia'
```

---

## Copy-paste snippets

### AMPscript

```ampscript
%%[
  var @firstName, @city

  set @firstName = "Sarah"
  set @city = "Singapore"
]%%

Hello %%=v(@firstName)=%%,

We are serving customers in %%=v(@city)=%%.
```

### SQL

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE IsActive = 1
ORDER BY FirstName ASC
```

### IF / ELSEIF

```ampscript
%%[
  var @customerTier
  set @customerTier = "Silver"
]%%

%%[ if @customerTier == "Gold" then ]%%
  Gold pricing applied.
%%[ elseif @customerTier == "Silver" then ]%%
  Silver pricing applied.
%%[ else ]%%
  Standard pricing applied.
%%[ endif ]%%
```

### FOR loop

```ampscript
%%[
  var @i

  for @i = 1 to 3 do
]%%
  Item %%=v(@i)=%%<br>
%%[
  next @i
]%%
```

---

## Additional guides

This repo includes multiple beginner-focused guides:

- `guide/marketers-guide.md` — marketing-oriented AMPscript + SQL guide
- `guide/query-builders-guide.md` — SQL-first view for segmentation and data preparation
- `guide/email-marketers-guide.md` — email-focused AMPscript examples
- `guide/copy-paste-kit.md` — quick snippets for campaigns and testing

These guides are intentionally simple and written for people who want practical, copy-ready examples rather than deep technical theory.

---

## Quick glossary

- AMPscript: SFMC scripting language
- Data Extension: table-style data store in SFMC
- Lookup: returns a single value from a DE
- Query Activity: SQL job in SFMC
- UNION: combines multiple result sets
- Segment: a filtered target audience

---

## Final note

This repository is a practical starter kit for SFMC beginners. Focus on the fundamentals first:
- Data Extension structure
- AMPscript personalization
- SQL segmentation and filtering

Once these are clear, creating better marketing logic and campaign setup becomes much easier.

Repository: https://github.com/kenxavierr/markops-builder-guide

Preview site (GitHub Pages): https://kenxavierr.github.io/markops-builder-guide/
