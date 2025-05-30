# ROI Tracking of Ad Campaigns using SAS

This SAS project analyzes advertising campaign data and calculates the **Return on Investment (ROI)** for each campaign. It is designed to help marketers and analysts understand which campaigns deliver the best financial returns across different channels and regions.

---

##  What is ROI?

**Return on Investment (ROI)** is a key performance indicator used to evaluate the profitability of an investment, in this case, an advertising campaign.

### ROI Formula:

ROI = {(Revenue - Adspend)/(Adspend)} * 100%

- ROI is expressed as a **percentage**.
- A positive ROI indicates a profitable campaign; a negative ROI indicates a loss.
- For example, an ROI of 1.5 means a 150% return on the initial spend.

---

##  Why Use ROI in Marketing?

ROI is essential for marketers and business leaders to:

- **Measure Effectiveness**: Understand how well each campaign performs financially.
- **Optimize Budget Allocation**: Invest more in campaigns that generate high ROI.
- **Compare Channels**: Evaluate which platforms (e.g., Social Media, Email, Search) deliver the best value.
- **Support Data-Driven Decisions**: Make informed decisions about scaling or halting campaigns.

---

##  Dataset

**File Name**: `ad_campaign_data.csv`  
**Columns**:

| Column Name     | Description                          |
|-----------------|--------------------------------------|
| CampaignID      | Unique identifier for the campaign   |
| Channel         | Marketing channel (e.g., Social, Email) |
| AdType          | Type of advertisement                |
| Region          | Geographic region                    |
| StartDate       | Campaign start date                  |
| EndDate         | Campaign end date                    |
| Impressions     | Number of ad views                   |
| Clicks          | Number of clicks                     |
| Conversions     | Number of goal completions           |
| AdSpend         | Cost incurred for the campaign       |
| Revenue         | Revenue generated by the campaign    |

---

##  SAS Workflow

1. **Import Data**: Reads the CSV using `PROC IMPORT`
2. **Data Preparation**: Calculates ROI and campaign duration
3. **Aggregation**: Summarizes KPIs and computes ROI at the campaign level
4. **Reporting**: Displays clean summary report using `PROC PRINT`
5. **Visualization** *(Optional)*: Histogram of ROI distribution using `PROC SGPLOT`

---

##  Output Example

A sample of the final output table:

| CampaignID | Channel | Total_AdSpend | Total_Revenue | ROI (%) |
|------------|---------|----------------|----------------|---------|
| C001       | Social  | $1,000         | $2,500         | 150.00% |
| C002       | Email   | $800           | $900           | 12.50%  |

---

##  Visualization

Optional ROI distribution plot using SAS ODS Graphics:

```sas
PROC SGPLOT DATA=campaign_summary;
    HISTOGRAM ROI / BINWIDTH=0.1;
RUN;
