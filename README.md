# Airflow_DBT_Superset_Project
# ITSM Data Engineering Challenge - Project README

## About the Project

This project is a complete End-to-End Data Engineering Solution built for an ITSM (IT Service Management) dataset, involving:

- Postgres Database setup and Data Cleaning
- DBT Models for Data Transformation
- Apache Airflow DAG for Workflow Orchestration
- Apache Superset Dashboard for Data Visualization

---

## Challenge Tasks Overview

### Task 1: Data Cleaning and Transformation

- Objective: Clean and transform the raw CSV data.

Steps Completed:

- Imported the given CSV data into a Postgres Database table (`incidents_staging`).
- SQL Queries and Actions:
  - Removed duplicate headers manually during CSV export.
  - Cleaned NULL values and standardized fields.
  - Corrected data types (timestamps, numeric columns).

DBT Models Created:

- `avg_resolution_time.sql`: Calculates average resolution time per category.
- `clean_incidents.sql`: Cleans up and standardizes the incident records.
- `closure_rate.sql`: Calculates closure rates.
- `monthly_ticket_summary.sql`: Summarizes ticket trends monthly.
- `tickets_with_dates.sql`: Creates ticket timelines.

Views Created:

- `Avg resolution time view.sql`
- `Clean incidents view.sql`
- `Closure rate view.sql`
- `Monthly ticket summary view.sql`

Outcome: A clean, staged, and properly structured dataset in `incidents_staging` ready for analytics.

---

### Task 2: Workflow Orchestration (Apache Airflow)

- Objective: Automate the entire ETL process.

Steps Completed:

- Created an Airflow DAG file: `final_etl_dag.py`.
[View DAG File](https://github.com/priyanshubiswas-tech/Airflow_DBT_Superset_Project/blob/main/Airflow%20DAG%20file/final_etl_dag.py)
- Tasks defined:
  1. CSV to Postgres ingestion: Using PostgresOperator with COPY command.
  2. DBT Model Execution: Using BashOperator to trigger `dbt run`.
  3. Validation Check: BashOperator to validate the DBT models completion.
- Scheduled DAG to run once every 24 hours.
- Connection used: Postgres Connection (`postgres_test`).



To demonstrate cross-platform compatibility and my understanding of the underlying system, the Airflow DAG was tested in a Docker Toolbox environment.

<img src="Media Stock/Airflow DAG success.png" alt="DAG Success" width="100%" />

*This image shows the successful execution of the Airflow DAG within a Docker Toolbox setup, validating its functionality across different environments. It highlights my familiarity with daemon processes, `pwd`, and other relevant packages.*


The following image, originating from Docker version 27.4.0, further illustrates the pipeline's operation.


<img src="Media Stock/Docker_Version_27.4.0_ -.jpeg" alt="Dcker Desktop Graph" width="100%" />

*This image displays the Airflow DAG's graph view, confirming the successful pipeline run and providing a visual representation of the workflow.*

Outcome: End-to-end automated pipeline that refreshes data daily, validated across platforms.

---

### Task 3: Data Visualization (Apache Superset)

- Objective: Create intuitive dashboards from transformed data.

Steps Completed:

- Connected Superset to the Postgres database (Docker container).
- Selected `incidents_staging` and final transformed tables as datasource.
- Created a Superset Dashboard with the following charts:
  - Ticket Volume Trends (Line Chart from `monthly_ticket_summary`)
  - Resolution Time (Bar Chart from `avg_resolution_time`)
  - Closure Rate (Pie Chart from `closure_rate`)
  - Ticket Backlog (Table from `tickets_with_dates`)

Added Filters for:

- Week
- Category
- Priority

Outcome: A dynamic dashboard ready for reporting and executive analysis. [View JSON File](https://github.com/priyanshubiswas-tech/Airflow_DBT_Superset_Project/blob/main/Superset%20Dashboard%20export%20(JSON)/Superset_dashbord.json)

---

## Project Structure

```
|- dags/
|    |- final_etl_dag.py
|- dbt/
|    |- models/
|         |- avg_resolution_time.sql
|         |- clean_incidents.sql
|         |- closure_rate.sql
|         |- monthly_ticket_summary.sql
|         |- tickets_with_dates.sql
|    |- views/
|         |- Avg resolution time view.sql
|         |- Clean incidents view.sql
|         |- Closure rate view.sql
|         |- Monthly ticket summary view.sql
|- superset/
|    |- itsm_dashboard.json
|- postgres/
|    |- incidents_staging (table)
```

---

## System Flow Overview (My Approach)

```markdown
+------------------+                 +---------------------+
| Local Machine    |                 | Docker Postgres DB   |
| (Windows GUI)    |                 | (port 5433 exposed)  |
+------------------+                 +---------------------+
         |                                  |
         | pgAdmin used for manual checks    |
         |---------------------------------->|

                +-------------------------+
                | Airflow (Docker)         |
                | DAGs using PostgresOperator |
                +-------------------------+
                           |
                           | triggers
                           v
                +-------------------------+
                | DBT (Transformations)    |
                | Executes models          |
                +-------------------------+
                           |
                           | provides transformed data
                           v
                +-------------------------+
                | Apache Superset          |
                | Visualizes final tables  |
                +-------------------------+
```

---

## Key Technologies Used

- PostgreSQL (Docker Container)
- DBT (Data Build Tool)
- Apache Airflow (Orchestration)
- Apache Superset (BI and Visualization)
- Docker Toolbox (Environment)

---

## Final Note

This solution ensures:

- Fully Automated and Reproducible ETL Pipeline
- Clean and Trusted Data for Visualization
- Professional Insights ready for Decision-Making

---

Thank you.

