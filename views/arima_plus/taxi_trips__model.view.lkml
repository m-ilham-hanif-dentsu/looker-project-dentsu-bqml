
view: taxi_trips__model {
  derived_table: {
    sql_create:
    CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
    OPTIONS(
        MODEL_TYPE='ARIMA_PLUS',
        TIME_SERIES_TIMESTAMP_COL='ts',
        TIME_SERIES_DATA_COL='total_rides',
        HOLIDAY_REGION='US',
        HORIZON=180
    ) AS
    SELECT
        CAST(day AS TIMESTAMP) ts,
        total_rides
    FROM ${taxi_trips__training.SQL_TABLE_NAME};;
    datagroup_trigger: datagroup__model
  }
}
