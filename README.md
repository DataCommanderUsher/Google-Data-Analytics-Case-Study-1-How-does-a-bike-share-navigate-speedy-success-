# Google-Data-Analytics-Case-Study-1-How-does-a-bike-share-navigate-speedy-success-

## Introduction
### Scenario
The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, your team wants to
understand how casual riders and annual members use Cyclistic bikes differently. From these
insights, your team will design a new marketing strategy to convert casual riders into annual
members. But first, Cyclistic executives must approve your recommendations, so they must be
backed up with compelling data insights and professional data visualizations. 

## Problems
Future growth depends on annual members, but currently, marketing targets broad segments.
Casual riders already know the brand; they are the easiest segment to convert.

## Solutions
Use data to find the behavioral gap between the two groups so marketing can bridge it.

## Conclusion

## Next steps

# Work
## A clear statement of the business task
Analyze historical Cyclistic bike trip data to identify distinct usage patterns between annual members and casual riders. 
These insights will inform a targeted marketing strategy aimed at converting casual riders into more profitable annual members.

## A description of all data sources used
**Source** : Cyclistic Historical Trip Data (Publicly available via Motivate International Inc.). 
**Date Range**: December 2024 to November 2025 (12 Months). 
**Storage & Processing**: Data was ingested into Google BigQuery due to volume (>5 million rows), surpassing local spreadsheet capacity. 
Integrity Checks:
* Data follows the ROCCC framework (Reliable, Original, Comprehensive, Current, Cited).
* Personal Identifying Information (PII) such as rider names and credit card numbers is contractually excluded from the source.
* Station metadata (names, IDs, coordinates) was validated for consistency.

## Documentation of any cleaning or manipulation of data
### Transformation Log:
**Consolidation**: Aggregated 12 individual monthly CSV files into a single BigQuery dataset (combined_trips).
### Feature Engineering:
* **Created ride_length_seconds**: Calculated the difference between ended_at and started_at to determine trip duration.
* **Created day_of_week**: Extracted the weekday integer (1=Sunday, 7=Saturday) from started_at for weekly trend analysis.
### Data Cleaning Log:
* **Initial Diagnostic**: Identified 33.89% of records (approx 1.9M rows) lacked station names.
* **Strategic Decision**: Unlike standard "cleaning" protocols which dictate removing incomplete rows,
                          I retained records with missing station names. Correlation analysis suggests these correlate with e-bike
                          usage (dockless locking). Removing them would introduce significant bias and underrepresent e-bike user behavior.
### Filters Applied:
* Removed 147,913 rows (approx 2.6%) where ride duration was < 60 seconds (false starts).
*Retained valid rides with 'NULL' station names for temporal analysis (time/duration), while excluding them only for specific geospatial (route) analysis.

## A summary of your analysis
## Supporting visualizations and key findings
## Your top three recommendations based on your analysis
