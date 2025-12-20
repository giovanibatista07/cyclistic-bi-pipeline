
# Cyclistic BI Pipeline

## Project Overview
This project is an end-to-end Business Intelligence (BI) pipeline developed for **Cyclistic**, a fictional NYC bike-share company, as part of the Google Business Intelligence Certificate.

The objective is to help Cyclistic’s Customer Growth and Product teams understand **customer demand, station usage, and seasonal trends** in order to inform **new station placement and capacity planning** decisions.

The solution focuses on building reliable reporting tables, validating data quality, and preparing analytics-ready datasets for Tableau dashboards.

---

## Business Problem
Cyclistic leadership needs to answer the following core question:

**How can customer usage insights be applied to inform new station growth and capacity planning?**

To support this, stakeholders require:
- High-level summaries for executives
- Detailed breakdowns for analysts
- Geographic and seasonal demand patterns
- Confidence in data accuracy and consistency

---

## Data Sources
This project integrates multiple public datasets:

- **NYC Citi Bike Trips**  
  Trip-level ride data, including start/end times, locations, and user types

- **US ZIP Code Boundaries (Census Bureau)**  
  Used to enrich trips with borough and neighborhood context

- **NOAA Weather Data**  
  Daily temperature, wind speed, and precipitation data for NYC

> Raw data is queried directly from BigQuery public datasets and is not stored in this repository due to size constraints.

---

## BI Architecture & Pipeline
The BI workflow follows a classic ETL-style reporting pattern:

1. **Extract**
   - Pull trip, geographic, and weather data from public BigQuery datasets

2. **Transform**
   - Enrich trips with ZIP codes, boroughs, and neighborhoods
   - Normalize trip duration into 10-minute buckets
   - Adjust dates to simulate recent activity (fictional scenario)

3. **Load**
   - Create analytics-ready reporting tables in BigQuery

---

## Reporting Tables
Two primary reporting tables were created:

- **`trips_full_year`**
  - Aggregated full-year trip data
  - Used for overall demand, user type, and geographic analysis

- **`trips_summer_trends`**
  - Focused on Summer 2015 (July–September)
  - Used for seasonal and peak-demand analysis

These tables are optimized for direct Tableau consumption.

---

## Data Quality & Validation
To ensure trust in downstream dashboards, multiple validation checks were implemented using SQL:

- NULL checks on geographic and temporal fields
- Distribution checks on user types and trip durations
- Outlier detection using percentile analysis
- Logical consistency checks (e.g., start date before stop date)

All validation queries are documented in the `/sql` directory.

---

## Repository Structure
```text
cyclistic-bi-pipeline/
├── sql/
│   ├── 01_create_trips_full_year.sql
│   ├── 02_create_trips_summer_trends.sql
│   ├── 03_data_quality_checks.sql
│   ├── 04_distribution_checks.sql
│   ├── 05_outlier_checks.sql
│   └── 06_validation_queries.sql
├── docs/
│   ├── Strategy_Document.pdf
│   ├── Project_Requirements.pdf
│   └── Stakeholder_Requirements.pdf
├── dashboards/
│   └── (Tableau dashboards added in Course 3)
└── README.md
