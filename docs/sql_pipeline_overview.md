
# Cyclistic BI SQL Pipeline Overview

This folder contains the SQL pipeline used to build reporting tables
for Cyclistic (NYC bike share) analysis.

## Pipeline Order

1. **01_create_trips_full_year.sql**
   Builds the core reporting table using 2014–2015 Citi Bike data,
   enriched with ZIP code boundaries and NOAA weather data.

2. **02_create_trips_summer_trends.sql**
   Creates a summer-only (Jul–Sep 2015) table optimized for trend
   analysis and dashboarding.

3. **03_data_quality_checks.sql**
   Validates NULLs on critical geographic and temporal fields.

4. **04_distribution_checks.sql**
   Explores user type, trip duration, and borough-level demand patterns.

5. **05_outlier_checks.sql**
   Identifies extreme values in trip duration and weather metrics.

6. **06_validation_queries.sql**
   Final logical consistency checks before dashboard consumption.
