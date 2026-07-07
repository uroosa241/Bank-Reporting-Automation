/*=========================================================
CUSTOMER_ANALYSIS.SQL
Banking & Loan Analytics Automation
=========================================================*/

-- Sheet: Total Customers

SELECT COUNT(*) AS Total_Customers
FROM customer;

------------------------------------------------------------

-- Sheet: Customers by Job

SELECT
    Job,
    COUNT(*) AS Total_Customers
FROM customer
GROUP BY Job
ORDER BY Total_Customers DESC;

------------------------------------------------------------

-- Sheet: Customers by Education

SELECT
    Education,
    COUNT(*) AS Total_Customers
FROM customer
GROUP BY Education
ORDER BY Total_Customers DESC;

------------------------------------------------------------

-- Sheet: Customers by Marital Status

SELECT
    MaritalStatus,
    COUNT(*) AS Total_Customers
FROM customer
GROUP BY MaritalStatus
ORDER BY Total_Customers DESC;

------------------------------------------------------------

-- Sheet: Average Balance by Job

SELECT
    c.Job,
    ROUND(AVG(f.Balance),2) AS Average_Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
GROUP BY c.Job
ORDER BY Average_Balance DESC;

------------------------------------------------------------

-- Sheet: Average Balance by Education

SELECT
    c.Education,
    ROUND(AVG(f.Balance),2) AS Average_Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
GROUP BY c.Education
ORDER BY Average_Balance DESC;

------------------------------------------------------------

-- Sheet: Average Balance by Marital Status

SELECT
    c.MaritalStatus,
    ROUND(AVG(f.Balance),2) AS Average_Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
GROUP BY c.MaritalStatus
ORDER BY Average_Balance DESC;

------------------------------------------------------------

-- Sheet: Highest Average Balance Job

SELECT
    c.Job,
    ROUND(AVG(f.Balance),2) AS Average_Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
GROUP BY c.Job
ORDER BY Average_Balance DESC
LIMIT 1;

------------------------------------------------------------

-- Sheet: Highest Average Balance Education

SELECT
    c.Education,
    ROUND(AVG(f.Balance),2) AS Average_Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
GROUP BY c.Education
ORDER BY Average_Balance DESC
LIMIT 1;

------------------------------------------------------------

-- Sheet: Top 20 Customers by Balance

SELECT
    c.CustomerID,
    f.Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
ORDER BY f.Balance DESC
LIMIT 20;

------------------------------------------------------------

-- Sheet: Bottom 20 Customers by Balance

SELECT
    c.CustomerID,
    f.Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
ORDER BY f.Balance
LIMIT 20;

------------------------------------------------------------

-- Sheet: Customers Above Overall Average Balance

SELECT
    c.CustomerID,
    f.Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
WHERE f.Balance >
(
    SELECT AVG(Balance)
    FROM financial
)
ORDER BY f.Balance DESC;

------------------------------------------------------------

-- Sheet: Customers Below Job Average Balance

SELECT
    c.CustomerID,
    c.Job,
    f.Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
WHERE f.Balance <
(
    SELECT AVG(f2.Balance)
    FROM customer c2
    JOIN marketing m2
    ON c2.CustomerID=m2.CustomerID
    JOIN financial f2
    ON m2.FinancialID=f2.FinancialID
    WHERE c2.Job=c.Job
);

------------------------------------------------------------

-- Sheet: Customer Value Segmentation

SELECT
    c.CustomerID,
    f.Balance,
    CASE
        WHEN f.Balance < 50000 THEN 'Low'
        WHEN f.Balance BETWEEN 50000 AND 150000 THEN 'Medium'
        ELSE 'High'
    END AS Customer_Value
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID;

------------------------------------------------------------

-- Sheet: Customers with Both Loans

SELECT
CustomerID,
PersonalLoan,
HousingLoan
FROM customer
WHERE PersonalLoan='yes'
AND HousingLoan='yes';

------------------------------------------------------------

-- Sheet: Customers with No Loans

SELECT
CustomerID,
PersonalLoan,
HousingLoan
FROM customer
WHERE PersonalLoan='no'
AND HousingLoan='no';

------------------------------------------------------------

-- Sheet: Loan Type Distribution

SELECT
'Personal Loan' AS Loan_Type,
COUNT(*) AS Total_Customers
FROM customer
WHERE PersonalLoan='yes'

UNION ALL

SELECT
'Housing Loan',
COUNT(*)
FROM customer
WHERE HousingLoan='yes';

------------------------------------------------------------

-- Sheet: Customers with Default History

SELECT
c.CustomerID,
c.Job,
c.Education,
f.Balance
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID
WHERE c.HasDefault='yes';

------------------------------------------------------------

-- Sheet: Balance Ranking

SELECT
c.CustomerID,
f.Balance,
RANK() OVER(ORDER BY f.Balance DESC) AS Balance_Rank
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID;

------------------------------------------------------------

-- Sheet: Job Wise Ranking

SELECT
c.CustomerID,
c.Job,
f.Balance,
RANK() OVER
(
PARTITION BY c.Job
ORDER BY f.Balance DESC
) AS Job_Rank
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID;

------------------------------------------------------------

-- Sheet: Customer Quartiles

SELECT
c.CustomerID,
f.Balance,
NTILE(4) OVER(ORDER BY f.Balance DESC) AS Quartile
FROM customer c
JOIN marketing m
ON c.CustomerID=m.CustomerID
JOIN financial f
ON m.FinancialID=f.FinancialID;

------------------------------------------------------------

-- Sheet: Duplicate Customers

SELECT
CustomerID,
COUNT(*) AS Duplicate_Count
FROM customer
GROUP BY CustomerID
HAVING COUNT(*)>1;

------------------------------------------------------------

-- Sheet: Education Percentage

SELECT
Education,
COUNT(*) AS Total_Customers,
ROUND(
COUNT(*)*100.0/
(SELECT COUNT(*) FROM customer),2
) AS Percentage
FROM customer
GROUP BY Education
ORDER BY Percentage DESC;