
-- =========================================================
-- 04_distribution_checks.sql
-- Distribution checks for Cyclistic reporting table
-- =========================================================

-- 4.1 User type distribution
SELECT
  usertype,
  COUNT(*) AS user_count,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`
GROUP BY usertype
ORDER BY user_count DESC;

-- 4.2 Trip duration distribution (bucketed at 10-min intervals already)
SELECT
  trip_minutes,
  COUNT(*) AS trip_groups
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`
GROUP BY trip_minutes
ORDER BY trip_minutes;

-- 4.3 Trip volume by borough (demand signal)
SELECT
  borough_start,
  SUM(trip_count) AS total_trips
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`
GROUP BY borough_start
ORDER BY total_trips DESC;
