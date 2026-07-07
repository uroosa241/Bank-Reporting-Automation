/*==============================================================
                EXECUTIVE KPI ANALYSIS
==============================================================*/

-- Sheet: Total Customers

SELECT
COUNT(*) AS total_customers
FROM customer;


------------------------------------------------------------

-- Sheet: Active Customers

SELECT
COUNT(*) AS active_customers
FROM customer
WHERE activecustomer = TRUE;


------------------------------------------------------------

-- Sheet: Customers with Housing Loan

SELECT
COUNT(*) AS housing_loan_customers
FROM customer
WHERE housingloan = 'yes';


------------------------------------------------------------

-- Sheet: Customers with Personal Loan

SELECT
COUNT(*) AS personal_loan_customers
FROM customer
WHERE personalloan = 'yes';


------------------------------------------------------------

-- Sheet: Total Account Balance

SELECT
SUM(balance) AS total_account_balance
FROM financial;


------------------------------------------------------------

-- Sheet: Average Account Balance

SELECT
ROUND(AVG(balance),2) AS average_account_balance
FROM financial;


------------------------------------------------------------

-- Sheet: Highest Account Balance

SELECT
MAX(balance) AS highest_account_balance
FROM financial;


------------------------------------------------------------

-- Sheet: Lowest Account Balance

SELECT
MIN(balance) AS lowest_account_balance
FROM financial;


------------------------------------------------------------

-- Sheet: Campaign Conversion Rate

SELECT

COUNT(*) AS total_contacts,

COUNT(*) FILTER
(
WHERE conversion = B'1'
) AS successful_conversions,

ROUND(

COUNT(*) FILTER
(
WHERE conversion = B'1'
)
*100.0/COUNT(*)

,2) AS conversion_rate

FROM marketing;


------------------------------------------------------------

-- Sheet: Average Call Duration

SELECT

ROUND(AVG(callduration),2) AS average_call_duration

FROM marketing;


------------------------------------------------------------

-- Sheet: Customer Default Rate

SELECT

COUNT(*) AS total_customers,

COUNT(*) FILTER
(
WHERE hasdefault='yes'
) AS default_customers,

ROUND(

COUNT(*) FILTER
(
WHERE hasdefault='yes'
)
*100.0/COUNT(*)

,2) AS default_rate

FROM customer;


------------------------------------------------------------

-- Sheet: Housing Loan Percentage

SELECT

COUNT(*) FILTER
(
WHERE housingloan='yes'
) AS housing_loan_customers,

ROUND(

COUNT(*) FILTER
(
WHERE housingloan='yes'
)
*100.0/COUNT(*)

,2) AS housing_loan_percentage

FROM customer;


------------------------------------------------------------

-- Sheet: Personal Loan Percentage

SELECT

COUNT(*) FILTER
(
WHERE personalloan='yes'
) AS personal_loan_customers,

ROUND(

COUNT(*) FILTER
(
WHERE personalloan='yes'
)
*100.0/COUNT(*)

,2) AS personal_loan_percentage

FROM customer;


------------------------------------------------------------

-- Sheet: Highest Conversion Contact Method

SELECT

c.contacttype,

ROUND(

COUNT(*) FILTER
(
WHERE m.conversion = B'1'
)
*100.0/COUNT(*)

,2) AS conversion_rate

FROM marketing m

JOIN contact c
ON m.contactid = c.contactid

GROUP BY c.contacttype

ORDER BY conversion_rate DESC;


------------------------------------------------------------

-- Sheet: Best Education Conversion Rate

SELECT

c.education,

ROUND(

COUNT(*) FILTER
(
WHERE m.conversion=B'1'
)
*100.0/COUNT(*)

,2) AS conversion_rate

FROM customer c

JOIN marketing m
ON c.customerid=m.customerid

GROUP BY c.education

ORDER BY conversion_rate DESC;


------------------------------------------------------------

-- Sheet: Top Job Category by Average Balance

SELECT

c.job,

ROUND(AVG(f.balance),2) AS average_balance

FROM customer c

JOIN marketing m
ON c.customerid=m.customerid

JOIN financial f
ON m.financialid=f.financialid

GROUP BY c.job

ORDER BY average_balance DESC

LIMIT 10;