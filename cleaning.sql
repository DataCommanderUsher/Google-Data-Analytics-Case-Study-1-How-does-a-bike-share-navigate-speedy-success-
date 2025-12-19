/*
Data Analysis Case Study: Cyclistic Bike-Share
Author: Usher Dube
Date: December 2025
Tool: Google BigQuery (SQL)
*/

-- =================================================================
-- STEP 1: DIAGNOSTIC ANALYSIS
-- Investigating data quality before cleaning.
-- =================================================================

-- 2.1: Check for Nulls and Short Rides
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(start_station_name IS NULL OR end_station_name IS NULL) AS missing_station_rows,
  COUNTIF(TIMESTAMP_DIFF(ended_at, started_at, SECOND) <= 60) AS short_ride_rows,
  
  -- Calculate potential data loss if we delete all errors
  COUNTIF(
    (start_station_name IS NULL OR end_station_name IS NULL) OR
    (TIMESTAMP_DIFF(ended_at, started_at, SECOND) <= 60)
  ) AS total_rows_to_remove,

  ROUND(
    COUNTIF(
      (start_station_name IS NULL OR end_station_name IS NULL) OR
      (TIMESTAMP_DIFF(ended_at, started_at, SECOND) <= 60)
    ) / COUNT(*) * 100,
  2) AS percentage_lost
FROM `cyclistic_2025.combined_trips`;

-- 2.2: Verify assumption that missing names = Electric Bikes
SELECT
  rideable_type,
  COUNT(*) as rides_with_missing_stations
FROM `cyclistic-analysis-2025.cyclistic_2025.combined_trips`
WHERE start_station_name IS NULL OR end_station_name IS NULL
GROUP BY rideable_type


-- =================================================================
-- STEP 2: DATA CLEANING & TRANSFORMATION
-- Creating the final "Gold" dataset for analysis.
-- Strategy: Keep missing stations (to track E-bike usage), delete false starts.
-- =================================================================

CREATE OR REPLACE TABLE `cyclistic_2025.cleaned_trips` AS
SELECT
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  
  -- Replace NULL stations with 'On Bike Lock / Unknown' to be explicit
  COALESCE(start_station_name, 'On Bike Lock / Unknown') AS start_station_name,
  COALESCE(end_station_name, 'On Bike Lock / Unknown') AS end_station_name,
  member_casual,

  -- Engineering: Calculate Ride Length in Seconds
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_seconds,

  -- Engineering: Extract Day of Week (1=Sunday, 7=Saturday)
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week

FROM
  `cyclistic_2025.combined_trips`

WHERE
  -- Remove rides shorter than 60 seconds (False Starts/Maintenance)
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) > 60
  

ORDER BY
  started_at DESC;

  -- =================================================================
-- STEP 3: CONSOLIDATE DATA
-- Merging 12 months of data (Dec 2024 - Nov 2025) into one table.
-- =================================================================

CREATE TABLE `cyclistic_2025.combined_trips` AS
SELECT * FROM `cyclistic_2025.trips_2024_12`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_01`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_02`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_03`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_04`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_05`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_06`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_07`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_08`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_09`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_10`
UNION ALL
SELECT * FROM `cyclistic_2025.trips_2025_11`;
