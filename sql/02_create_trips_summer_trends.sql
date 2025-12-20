
-- =========================================================
-- 02_create_trips_summer_trends.sql
-- Build summer-season table (Jul–Sep 2015) for trend analysis
-- Project: extended-tenure-480902-q3
-- Dataset: cyclistic_reporting
-- Output: trips_summer_trends
-- =========================================================

CREATE OR REPLACE TABLE `extended-tenure-480902-q3.cyclistic_reporting.trips_summer_trends` AS
SELECT
  TRI.usertype,

  TRI.start_station_longitude,
  TRI.start_station_latitude,
  TRI.end_station_longitude,
  TRI.end_station_latitude,

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

  -- Group trips into 10-minute intervals
  ROUND(CAST(TRI.tripduration / 60 AS INT64), -1) AS trip_minutes,

  -- Keep trip-level identifier for downstream trend analysis
  TRI.bikeid

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
  AND DATE(TRI.starttime) BETWEEN DATE('2015-07-01') AND DATE('2015-09-30');
