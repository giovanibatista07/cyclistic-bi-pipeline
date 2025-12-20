
-- =========================================================
-- 05_outlier_checks.sql
-- Outlier and extreme value checks
-- =========================================================

-- 5.1 Trip duration outliers (min / max / high percentiles)
SELECT
  MIN(trip_minutes) AS min_trip_minutes,
  MAX(trip_minutes) AS max_trip_minutes,
  APPROX_QUANTILES(trip_minutes, 100)[OFFSET(95)] AS p95_trip_minutes,
  APPROX_QUANTILES(trip_minutes, 100)[OFFSET(99)] AS p99_trip_minutes
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`;

-- Optional: Inspect the longest trip groups (top 50)
SELECT
  trip_minutes,
  trip_count,
  start_day,
  borough_start,
  neighborhood_start
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`
ORDER BY trip_minutes DESC
LIMIT 50;

-- 5.2 Weather outliers (min/max sanity)
SELECT
  MIN(day_mean_temperature) AS min_temp,
  MAX(day_mean_temperature) AS max_temp,
  MIN(day_total_precipitation) AS min_precip,
  MAX(day_total_precipitation) AS max_precip
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`;
