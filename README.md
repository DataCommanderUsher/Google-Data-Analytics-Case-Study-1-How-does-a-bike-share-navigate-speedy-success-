# Case Study: How Does a Bike-Share Navigate Speedy Success?
* **Author**: Usher Dube 
* **Date**: 18 December 2025 
* **Role**: Lead Data Analyst

## 1. Executive Summary
### The Challenge
Cyclistic, a bike-share company in Chicago, aims to maximize the number of annual memberships, 
which are more profitable than casual single-ride passes. The Director of Marketing believes 
the key to future growth lies in converting casual riders into members.

### The Goal
Analyze 12 months of historical trip data to identify distinct behavioral differences between 
annual members and casual riders. These insights will drive a targeted marketing campaign.

## 2. Business Task
**Objective**: Analyze historical Cyclistic bike trip data to identify distinct usage patterns 
between annual members and casual riders. 
**Outcome**: Design a data-driven marketing strategy aimed at converting casual riders into profitable
annual members by bridging the gap between "leisure" and "utility" usage.

## 3. Data Sources & Engineering
* **Dataset**: Cyclistic Historical Trip Data (Publicly available via Motivate International Inc.). 
* **Date Range**: December 2024 to November 2025 (12 Months). 
* **Infrastructure**: Google BigQuery (SQL) for processing & R (Posit) for visualization.

**Data Integrity & ROCCC**
* **Reliable/Original**: Primary data sourced directly from the operator.
* **Comprehensive**: >5 million rows processed, covering a full seasonality cycle.
* **Privacy**: PII (names, credit cards) excluded contractually.

**Transformation Log (SQL)**
Due to the dataset size (>5 million rows), data was processed in the cloud (BigQuery) rather than local spreadsheets.

1. **Consolidation**: Aggregated 12 monthly CSV files into a single combined_trips dataset.
1. **Feature Engineering:**
* **ride_length_seconds**: Calculated trip duration (ended_at - started_at).
* **day_of_week**: Extracted integer (1=Sun, 7=Sat) for weekly trending.
* **month_name**: Extracted month name for month analysis.

**Cleaning Strategy (Crucial Step):**
* **Station Data**: Diagnostic analysis revealed ~34% of rides lacked station names. Correlation analysis linked this to
  **Electric Bike** usage (dockless locking) as shown in pciture below. Electric Bikes have the the highest missing data
* <img width="488" height="106" alt="image" src="https://github.com/user-attachments/assets/b027d8f6-cc68-4486-a9ea-9d9797f0f454" />
* **Strategic Decision**: These records were retained to avoid underrepresenting e-bike behavior, unlike standard cleaning protocols that might delete them.
* **False Starts**: Removed 147,913 rides (<2.6%) with duration under 60 seconds.

# 4. Analysis & Visualizations
**Insight 1**: The "Commuter" vs. "Explorer" Split
* Members use the system for commuting, with stable usage Monday through Friday. Casuals are "Weekend Warriors," with ridership surging over 50% on Saturdays and Sundays.
* <img width="490" height="481" alt="image" src="https://github.com/user-attachments/assets/c73edb4a-c654-421f-9527-42b3a053c7b1" />
* **Figure 1**: Total volume of rides broken down by day. Note the massive Casual spike on weekends.

**Insight 2: Usage Duration**
* Casual riders do not just ride on different days; they ride differently. Their average trip duration is nearly double that of members (~28 mins vs ~14 mins). This confirms they are paying for "time," while members pay for "transport."
* <img width="468" height="472" alt="image" src="https://github.com/user-attachments/assets/83bb4401-d5ea-4cbd-a05f-bbb37f0704f3" />
* **Figure 2**: Average time spent on a bike per trip. Casuals (Red) consistently hold bikes longer.

**Insight 3: Seasonality**
* Both groups peak in August, but Casual demand is highly elastic. It collapses in the winter months, suggesting marketing spend should be paused in Q4/Q1 and aggressive in Q2/Q3.
* <img width="471" height="474" alt="image" src="https://github.com/user-attachments/assets/3593fe4f-8714-4f06-9a14-8f89b71e73dd" />
* **Figure 3**: Monthly ridership trends showing the Summer peak.

**Insight 4: Product Preference**
* Contrary to assumption, Electric Bikes are the preferred vehicle for both groups, but Casuals show a particularly strong affinity for them. The flexibility of e-bikes (dockless ending) aligns with their leisure use case.
*<img width="470" height="467" alt="image" src="https://github.com/user-attachments/assets/6a3ac8bf-1c4f-44ca-a500-4b6ebeebe40a" />
* **Figure 4**: Total rides by bike type. Electric bikes outperform classic bikes across both segments.

## 5. Recommendations
Based on the data, I propose the following strategic pivots:

**1. Launch a "Weekend Warrior" Mini-Membership**
* **The Data**: Casual usage spikes on Sat/Sun.
* **The Strategy**: Create a new membership tier valid only on weekends (Fri-Sun). This lowers the barrier to entry for Casuals who feel a full annual pass is "wasted" on weekdays.

**2. "Summer Fun" Marketing Campaign**
* **The Data**: Casuals ride for 28+ minutes (Leisure) and prefer Electric Bikes.
* **The Strategy**: Stop marketing "convenience." Start marketing "adventure." Use visuals of groups riding e-bikes to parks and beaches. Target ads during the pre-season (April/May) to capture the summer wave early.

**3. Gamified Conversion via E-Bike Discounts**
* **The Data**: Casuals prefer E-Bikes but pay a premium per minute.
* **The Strategy**: Send targeted in-app notifications: "You spent $15 on E-Bike fees this weekend. Annual Members get 50% off E-Bike rides. Switch now and save." Use their own usage data to justify the cost.

# Appendix: Technical Resources
* **SQL Cleaning Script**: [https://github.com/DataCommanderUsher/Google-Data-Analytics-Case-Study-1-How-does-a-bike-share-navigate-speedy-success-/blob/main/cleaning.sql]
* **R Analysis Script**: [https://github.com/DataCommanderUsher/Google-Data-Analytics-Case-Study-1-How-does-a-bike-share-navigate-speedy-success-/blob/main/analysis.R]
