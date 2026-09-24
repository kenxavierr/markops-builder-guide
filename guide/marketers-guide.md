# Marketers Guide

This guide is written for marketing teams who need practical, readable SFMC logic for personalization and campaign setup.

## Beginner AMPscript for marketers

### Dynamic greeting

```ampscript
%%[
  var @firstName
  set @firstName = Lookup("ENT.CustomerMaster","FirstName","SubscriberKey",AttributeValue("SubscriberKey"))
]%%

Hi %%=v(@firstName)=%%,
```

### Offer logic

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

### Simple loop

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

## Basic SQL for audiences

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

## Best practices

- Keep Data Extension names consistent
- Keep logic readable for non-developers
- Always preview before send
- Use `WHERE` filters to limit audience size

---

## Quick checklist

- Understand your DE fields
- Use AMPscript for dynamic content
- Use SQL for audience prep
- Test before launch
