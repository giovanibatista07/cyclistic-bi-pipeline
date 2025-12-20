
-- =========================================================
-- 06_validation_queries.sql
-- Validation / logical consistency checks
-- =========================================================

-- 6.1 Logical consistency check (stop_day should not be before start_day)
SELECT
  COUNT(*) AS invalid_time_rows
FROM `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year`
WHERE stop_day < start_day;
