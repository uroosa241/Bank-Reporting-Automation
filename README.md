#  Bank Reporting Automation

A professional Banking Reporting Automation project built using PostgreSQL, SQL, Python, and Power BI. This solution automatically executes multiple SQL reports, exports report outputs into CSV files, and provides ready-to-use datasets for Power BI dashboards.

---

##  Project Overview

This project simulates a real-world banking reporting environment where business reports are generated automatically from a PostgreSQL database.

The automation framework:

- Connects to PostgreSQL
- Reads SQL files automatically
- Executes multiple business reports
- Exports every report as CSV
- Creates execution logs
- Supports Power BI dashboards
- Can be scheduled using Windows Task Scheduler

---

## Tech Stack

- PostgreSQL
- SQL
- Python
- Pandas
- psycopg2
- Power BI
- Windows Task Scheduler
- Git & GitHub

---

#  Project Structure

```
Bank-Reporting-Automation/

│
├── sql/
│   ├── executive_kpi.sql
│   ├── customer_analysis.sql
│   ├── financial_analysis.sql
│   ├── loan_campaign_analysis.sql
│
├── output/
│
├── logs/
│
├── report.py
├── config.py
├── run_report.bat
├── requirements.txt
├── .gitignore
└── README.md
```

---

#  Automated Reports

##  Executive KPI

- Total Customers
- Active Customers
- Total Account Balance
- Average Account Balance
- Highest Balance
- Lowest Balance
- Campaign Success Rate
- Previous Campaign Success Rate
- Housing Loan %
- Personal Loan %
- Default Rate

---

## Customer Analysis

- Total Customers
- Customers by Job
- Customers by Education
- Customers by Marital Status
- Average Balance by Job
- Average Balance by Education
- Average Balance by Marital Status
- Customer Value Segmentation
- Top Customers by Balance
- Bottom Customers by Balance
- Balance Ranking
- Customer Quartiles
- Loan Distribution
- Default Customers

---

##  Financial Analysis

- Total Account Balance
- Average Balance
- Highest Balance
- Lowest Balance
- Balance Distribution
- High Value Customers
- Balance by Customer Segment
- Financial KPIs

---

##  Loan Campaign Analysis

- Total Campaigns
- Successful Campaigns
- Failed Campaigns
- Campaign Success Rate
- Previous Campaign Success Rate
- Average Campaign Calls
- Average Calls Before Conversion
- Monthly Campaign Trend
- Monthly Conversion Growth
- Running Total Conversions
- Best Performing Month
- Campaign Success by Job
- Campaign Success by Education
- Campaign Success by Marital Status
- Campaign Success by Age Group
- Top Campaigns
- Contact Frequency Analysis

---

# Automation Workflow

```
PostgreSQL Database
        │
        ▼
Python Automation
(report.py)
        │
        ▼
Read SQL Files
        │
        ▼
Execute SQL Queries
        │
        ▼
Export CSV Reports
        │
        ▼
Generate Logs
        │
        ▼
Power BI Dashboard
        │
        ▼
Windows Task Scheduler
```

---

# Features

- Automated SQL Execution
- Multi-file SQL Processing
- Dynamic CSV Export
- Logging
- Error Handling
- PostgreSQL Integration
- Power BI Integration
- Windows Task Scheduler Support
- Scalable Reporting Framework

---

# Output

CSV reports are automatically generated inside:

```
output/
```

Example:

```
output/

executive_kpi/
customer_analysis/
financial_analysis/
loan_campaign_analysis/
```

Each SQL report produces multiple CSV files that can be directly consumed by Power BI.

---

#  Logging

Execution logs are stored inside:

```
logs/automation.log
```

The logs include:

- Successful report execution
- Failed queries
- Error messages
- Execution time

---

# How to Run

## 1. Clone Repository

```bash
git clone https://github.com/uroosakhan/Bank-Reporting-Automation.git
```

---

## 2. Install Requirements

```bash
pip install -r requirements.txt
```

---

## 3. Configure PostgreSQL

Update `config.py`

```python
DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "BankDatabase",
    "user": "postgres",
    "password": "_password"
}
```

---

## 4. Run Automation

```bash
python report.py
```

or

```bash
run_report.bat
```

---

#  Power BI Dashboard

The generated CSV reports are connected directly to Power BI.

Dashboard refresh process:

1. Execute Python Automation
2. CSV files are regenerated
3. Open Power BI
4. Click **Refresh**
5. Dashboard updates automatically

---

#  Skills Demonstrated

- SQL Reporting
- PostgreSQL
- Python Automation
- Business Intelligence
- Power BI Dashboard Development
- ETL Reporting
- Window Functions
- CTEs
- Aggregate Analysis
- Reporting Automation
- Windows Task Scheduler
- Git & GitHub

---

# 👨‍💻 Author

**Uroosa khan**

**SQL | Python | Power BI | PostgreSQL | Reporting Automation | Business Intelligence**
