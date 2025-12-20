
-- =========================================================
-- 01_create_trips_full_year.sql
-- Build full-year reporting table (2014–2015) for Tableau
-- Project: extended-tenure-480902-q3
-- Dataset: cyclistic_reporting
-- Output: trips_full_year
-- =========================================================

CREATE OR REPLACE TABLE `extended-tenure-480902-q3.cyclistic_reporting.trips_full_year` AS
SELECT
  TRI.usertype,

  ZIPSTART.zip_code AS zip_code_start,
  ZIPSTARTNAME.borough AS borough_start,
  ZIPSTARTNAME.neighborhood AS neighborhood_start,

  ZIPEND.zip_code AS zip_code_end,
  ZIPENDNAME.borough AS borough_end,
  ZIPENDNAME.neighborhood AS neighborhood_end,

  -- Make dates look recent for the fictional dashboard
  DATE_ADD(DATE(TRI.starttime), INTERVAL 5 YEAR) AS start_day,
  DATE_ADD(DATE(TRI.stoptime), INTERVAL 5 YEAR) AS stop_day,

  WEA.temp AS day_mean_temperature,
  WEA.wdsp AS day_mean_wind_speed,
  WEA.prcp AS day_total_precipitation,

  -- Group trips into 10-minute intervals to reduce row volume
  ROUND(CAST(TRI.tripduration / 60 AS INT64), -1) AS trip_minutes,
  COUNT(TRI.bikeid) AS trip_count

FROM `bigquery-public-data.new_york_citibike.citibike_trips` AS TRI

INNER JOIN `bigquery-public-data.geo_us_boundaries.zip_codes` AS ZIPSTART
  ON ST_WITHIN(
    ST_GEOGPOINT(TRI.start_station_longitude, TRI.start_station_latitude),
    ZIPSTART.zip_code_geom
  )

INNER JOIN `bigquery-public-data.geo_us_boundaries.zip_codes` AS ZIPEND
  ON ST_WITHIN(
    ST_GEOGPOINT(TRI.end_station_longitude, TRI.end_station_latitude),
    ZIPEND.zip_code_geom
  )

INNER JOIN `bigquery-public-data.noaa_gsod.gsod20*` AS WEA
  ON PARSE_DATE('%Y%m%d', CONCAT(WEA.year, WEA.mo, WEA.da)) = DATE(TRI.starttime)

INNER JOIN `extended-tenure-480902-q3.zipcodenyc_list.zipcodenyc` AS ZIPSTARTNAME
  ON ZIPSTART.zip_code = CAST(ZIPSTARTNAME.zip AS STRING)

INNER JOIN `extended-tenure-480902-q3.zipcodenyc_list.zipcodenyc` AS ZIPENDNAME
  ON ZIPEND.zip_code = CAST(ZIPENDNAME.zip AS STRING)

WHERE
  WEA.wban = '94728' -- NEW YORK CENTRAL PARK
  AND EXTRACT(YEAR FROM DATE(TRI.starttime)) BETWEEN 2014 AND 2015

GROUP BY
  1,2,3,4,5,6,7,8,9,10,11,12,13;
