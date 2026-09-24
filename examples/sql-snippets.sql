/* Basic SELECT */
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  LastName
FROM ent.CustomerMaster;

/* Filter active customers */
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  Country
FROM ent.CustomerMaster
WHERE IsActive = 1;

/* Select by country */
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE Country = 'Malaysia';

/* JOIN example */
SELECT
  c.SubscriberKey,
  c.EmailAddress,
  c.FirstName,
  o.OrderID,
  o.TotalAmount
FROM ent.CustomerMaster c
LEFT JOIN ent.CustomerOrders o
  ON c.SubscriberKey = o.SubscriberKey;

/* UNION example */
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
FROM ent.Customers_Malaysia;

/* ORDER BY and LIMIT */
SELECT TOP 100
  SubscriberKey,
  EmailAddress,
  FirstName
FROM ent.CustomerMaster
WHERE IsActive = 1
ORDER BY FirstName ASC;

/* Create a target DE from a query */
SELECT
  SubscriberKey,
  EmailAddress,
  FirstName,
  Country
INTO ent.Malaysia_Active_Customers
FROM ent.CustomerMaster
WHERE IsActive = 1
  AND Country = 'Malaysia';
