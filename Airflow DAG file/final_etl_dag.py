from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.utils.task_group import TaskGroup
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

with DAG(
    dag_id='final_etl_dag',
    default_args=default_args,
    description='Full ETL flow: CSV ingestion + DBT transformations + Validation',
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False
) as dag:

    start = DummyOperator(
        task_id='start'
    )

    # 1. Load CSV into Postgres
    csv_to_postgres = PostgresOperator(
        task_id='csv_to_postgres',
        postgres_conn_id='postgres_test',
        sql="""
        COPY monthly_ticket_summary(ticket_month, total_tickets, avg_resolution_time_hrs, closure_rate_percentage)
        FROM '/monthly_ticket_summary_export.csv'
        DELIMITER ',' CSV HEADER;
        """
    )

    # 2. Run DBT Models
    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command="""
        cd /usr/app/itsm_project &&
        dbt run
        """
    )

    # 3. Validate DBT run completed
    validate_dbt = BashOperator(
        task_id='validate_dbt',
        bash_command="echo 'DBT models finished running successfully!'"
    )

    end = DummyOperator(
        task_id='end'
    )

    # task pipeline
    start >> csv_to_postgres >> dbt_run >> validate_dbt >> end