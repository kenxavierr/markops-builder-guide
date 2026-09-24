# Email Marketers Guide

This version is focused on email personalization and campaign-ready AMPscript.

## Personalized greeting

```ampscript
%%[
  var @firstName
  set @firstName = Lookup("ENT.CustomerMaster","FirstName","SubscriberKey",AttributeValue("SubscriberKey"))
]%%

Hi %%=v(@firstName)=%%,
```

## Conditional content

```ampscript
%%[
  var @customerTier
  set @customerTier = "Gold"
]%%

%%[ if @customerTier == "Gold" then ]%%
  Gold member pricing is active.
%%[ else ]%%
  Standard pricing applies.
%%[ endif ]%%
```

## Dynamic offer block

```ampscript
%%[
  var @country, @discount
  set @country = "Malaysia"
]%%

%%[ if @country == "Singapore" then ]%%
  %%[ set @discount = 15 ]%%
  Enjoy 15% off your order.
%%[ elseif @country == "Malaysia" then ]%%
  %%[ set @discount = 10 ]%%
  Enjoy 10% off your order.
%%[ else ]%%
  %%[ set @discount = 5 ]%%
  Enjoy 5% off your order.
%%[ endif ]%%
```

## Quick email checklist

- Confirm Data Extension keys
- Personalize subject line and preview text
- Keep conditional logic readable
- Test content per segment
