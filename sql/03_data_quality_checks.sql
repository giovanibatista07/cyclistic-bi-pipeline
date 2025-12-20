-- =========================================================
-- 03_data_quality_checks.sql
-- Data quality checks for Cyclistic reporting table
-- Target table: extended-tenure-480902-q3.cyclistic_reporting.trips_full_year
-- =========================================================

-- 3.1 NULL checks on critical geographic fields
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(zip_code_start IS NULL) AS null_zip_start,
  COUNTIF(borough_start IS NULL) AS null_borough_start,
  COUNTIF(neighborhood_start IS NULL) AS null_neighborhood_start,
  COUNTIF(zip_code_end IS NULL) AS null_zip_end,
  COUNTIF(borough_end IS NULL) AS null_borough_end,
  COUNTIF(neighborhood_end IS NULL) AS null_neighborhood_end
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`;

-- 3.2 NULL checks on temporal and usage fields
SELECT
  COUNTIF(start_day IS NULL) AS null_start_day,
  COUNTIF(stop_day IS NULL) AS null_stop_day,
  COUNTIF(trip_minutes IS NULL) AS null_trip_minutes,
  COUNTIF(trip_count IS NULL) AS null_trip_count
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`;
