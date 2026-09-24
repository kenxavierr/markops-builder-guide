# Copy-Paste Kit

This file is a quick reference for common SFMC snippets.

## AMPscript: variables

```ampscript
%%[
  var @firstName, @city

  set @firstName = "Sarah"
  set @city = "Singapore"
]%%

Hello %%=v(@firstName)=%%,

We are serving customers in %%=v(@city)=%%.
```

## AMPscript: IF / ELSEIF

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

## AMPscript: FOR loop

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

## SQL: basic select

```sql
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE IsActive = 1
ORDER BY FirstName ASC
```

## SQL: JOIN

```sql
SELECT
  c.SubscriberKey,
  c.EmailAddress,
  c.FirstName,
  o.OrderID
FROM ent.CustomerMaster c
LEFT JOIN ent.CustomerOrders o
  ON c.SubscriberKey = o.SubscriberKey
```

## SQL: UNION ALL

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
