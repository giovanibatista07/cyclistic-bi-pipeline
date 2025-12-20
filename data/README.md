
## Data Outputs (Not Stored in Repo)

The final reporting tables for this project were generated in Google BigQuery but are not stored in this repository due to size constraints.

### Tables Created
- `cyclistic_reporting.trips_full_year`
  - Full-year aggregated reporting table (2014–2015, shifted +5 years)
  - ~210 MB as CSV export

- `cyclistic_reporting.trips_summer_trends`
  - Summer-only subset (July–September 2015)
  - ~81 MB as CSV export

### Reason for Exclusion
These tables exceed GitHub file size limits and reflect production-style BI outputs that are typically queried directly from a data warehouse rather than stored in version control.

### Reproducibility
All SQL required to recreate these tables is included in the `/sql` directory.
Any reviewer can regenerate the outputs by executing the SQL in BigQuery.
