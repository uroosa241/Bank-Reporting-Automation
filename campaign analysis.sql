/*==============================================================
                LOAN CAMPAIGN ANALYSIS
==============================================================*/

-- Sheet: Total Campaigns

SELECT
COUNT(*) AS total_campaigns
FROM campaign;

------------------------------------------------------------

-- Sheet: Successful Campaigns

SELECT
COUNT(*) AS successful_campaigns
FROM campaign
WHERE previousoutcome='success';

------------------------------------------------------------

-- Sheet: Failed Campaigns

SELECT
COUNT(*) AS failed_campaigns
FROM campaign
WHERE previousoutcome='failure';

------------------------------------------------------------

-- Sheet: Campaign Success Rate

SELECT
COUNT(*) AS total_campaigns,
COUNT(*) FILTER(WHERE loanapproved=TRUE) AS successful_campaigns,
ROUND(
COUNT(*) FILTER(WHERE loanapproved=TRUE)*100.0/COUNT(*),
2
) AS campaign_success_rate
FROM marketing;

------------------------------------------------------------

-- Sheet: Previous Campaign Success Rate

SELECT
COUNT(*) AS total_campaigns,
COUNT(*) FILTER(WHERE previousoutcome='success') AS successful_campaigns,
ROUND(
COUNT(*) FILTER(WHERE previousoutcome='success')*100.0/COUNT(*),
2
) AS previous_success_rate
FROM campaign;

------------------------------------------------------------

-- Sheet: Average Campaign Calls

SELECT
ROUND(AVG(campaigncalls),2) AS average_campaign_calls
FROM campaign;

------------------------------------------------------------

-- Sheet: Average Calls Before Conversion

SELECT
ROUND(AVG(c.campaigncalls),2) AS average_calls_before_conversion
FROM campaign c
JOIN marketing m
ON c.campaignid=m.campaignid
WHERE m.conversion='1';

------------------------------------------------------------

-- Sheet: Highest Conversion Month

SELECT
TO_CHAR(applicationdate,'Mon YYYY') AS month,
SUM(conversion::INT) AS total_conversions
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
ORDER BY total_conversions DESC
LIMIT 1;

------------------------------------------------------------

-- Sheet: Lowest Conversion Month

SELECT
TO_CHAR(applicationdate,'Mon YYYY') AS month,
SUM(conversion::INT) AS total_conversions
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
ORDER BY total_conversions
LIMIT 1;

------------------------------------------------------------

-- Sheet: Previous Outcome Success Rate

SELECT
c.previousoutcome,
COUNT(*) AS total_customers,
SUM(m.conversion::INT) AS successful_conversions,
ROUND(
SUM(m.conversion::INT)*100.0/COUNT(*),
2
) AS success_rate
FROM campaign c
JOIN marketing m
ON c.campaignid=m.campaignid
GROUP BY c.previousoutcome
ORDER BY success_rate DESC;

------------------------------------------------------------

-- Sheet: Monthly Average Call Duration

SELECT
TO_CHAR(applicationdate,'Mon YYYY') AS month,
ROUND(AVG(callduration),2) AS average_call_duration
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
ORDER BY DATE_TRUNC('month',applicationdate);

------------------------------------------------------------

-- Sheet: Top 10 Campaigns

SELECT
c.campaignid,
COUNT(*) AS total_contacts,
SUM(conversion::INT) AS successful_conversions,
ROUND(
SUM(conversion::INT)*100.0/COUNT(*),
2
) AS conversion_rate
FROM campaign c
JOIN marketing m
ON c.campaignid=m.campaignid
GROUP BY c.campaignid
ORDER BY successful_conversions DESC
LIMIT 10;

------------------------------------------------------------

-- Sheet: Customers Contacted More Than Five Times

SELECT
m.customerid,
c.campaigncalls
FROM marketing m
JOIN campaign c
ON m.campaignid=c.campaignid
WHERE campaigncalls>5
ORDER BY campaigncalls DESC;

------------------------------------------------------------

-- Sheet: One Call Converted Customers

SELECT
m.customerid,
c.campaigncalls,
m.conversion
FROM campaign c
JOIN marketing m
ON c.campaignid=m.campaignid
WHERE campaigncalls=1
AND conversion='1';

------------------------------------------------------------

-- Sheet: Campaign Success by Education

SELECT
c.education,
COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE loanapproved=TRUE) AS successful_campaigns,
ROUND(
COUNT(*) FILTER(WHERE loanapproved=TRUE)*100.0/COUNT(*),
2
) AS success_rate
FROM customer c
JOIN marketing m
ON c.customerid=m.customerid
GROUP BY c.education
ORDER BY success_rate DESC;

------------------------------------------------------------

-- Sheet: Campaign Success by Job

SELECT
c.job,
COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE loanapproved=TRUE) AS successful_campaigns,
ROUND(
COUNT(*) FILTER(WHERE loanapproved=TRUE)*100.0/COUNT(*),
2
) AS success_rate
FROM customer c
JOIN marketing m
ON c.customerid=m.customerid
GROUP BY c.job
ORDER BY success_rate DESC;

------------------------------------------------------------

-- Sheet: Campaign Success by Age Group

SELECT
CASE
WHEN age BETWEEN 18 AND 25 THEN '18-25'
WHEN age BETWEEN 26 AND 35 THEN '26-35'
WHEN age BETWEEN 36 AND 45 THEN '36-45'
WHEN age BETWEEN 46 AND 55 THEN '46-55'
ELSE '56+'
END AS age_group,

COUNT(*) AS total_customers,

COUNT(*) FILTER(WHERE loanapproved=TRUE) AS successful_campaigns,

ROUND(
COUNT(*) FILTER(WHERE loanapproved=TRUE)*100.0/COUNT(*),
2
) AS success_rate

FROM customer c
JOIN marketing m
ON c.customerid=m.customerid

GROUP BY age_group

ORDER BY success_rate DESC;

------------------------------------------------------------

-- Sheet: Campaign Success by Marital Status

SELECT
maritalstatus,
COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE loanapproved=TRUE) AS successful_campaigns,
ROUND(
COUNT(*) FILTER(WHERE loanapproved=TRUE)*100.0/COUNT(*),
2
) AS success_rate
FROM customer c
JOIN marketing m
ON c.customerid=m.customerid
GROUP BY maritalstatus
ORDER BY success_rate DESC;

------------------------------------------------------------

-- Sheet: Monthly Campaign Trend

SELECT
TO_CHAR(applicationdate,'Mon YYYY') AS month,
COUNT(*) AS total_contacts,
SUM(conversion::INT) AS successful_conversions,
ROUND(
SUM(conversion::INT)*100.0/COUNT(*),
2
) AS conversion_rate,
ROUND(AVG(callduration),2) AS average_call_duration
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
ORDER BY DATE_TRUNC('month',applicationdate);

------------------------------------------------------------

-- Sheet: Running Total Conversions

SELECT
TO_CHAR(applicationdate,'Mon YYYY') AS month,
SUM(conversion::INT) AS monthly_conversions,
SUM(SUM(conversion::INT))
OVER(
ORDER BY DATE_TRUNC('month',applicationdate)
) AS running_total
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
ORDER BY DATE_TRUNC('month',applicationdate);

------------------------------------------------------------

-- Sheet: Monthly Conversion Growth

WITH monthly_growth AS
(
SELECT
DATE_TRUNC('month',applicationdate) AS month_date,
TO_CHAR(applicationdate,'Mon YYYY') AS month,
SUM(conversion::INT) AS conversions
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
)

SELECT
month,
conversions,
LAG(conversions) OVER(ORDER BY month_date) AS previous_month,
ROUND(
(conversions-LAG(conversions) OVER(ORDER BY month_date))
*100.0/
NULLIF(LAG(conversions) OVER(ORDER BY month_date),0),
2
) AS growth_percentage
FROM monthly_growth
ORDER BY month_date;

------------------------------------------------------------

-- Sheet: Best Performing Campaign Month

SELECT
TO_CHAR(applicationdate,'Mon YYYY') AS month,
COUNT(*) AS total_contacts,
SUM(conversion::INT) AS successful_conversions,
ROUND(
SUM(conversion::INT)*100.0/COUNT(*),
2
) AS conversion_rate
FROM marketing
GROUP BY
DATE_TRUNC('month',applicationdate),
TO_CHAR(applicationdate,'Mon YYYY')
ORDER BY conversion_rate DESC
LIMIT 1;