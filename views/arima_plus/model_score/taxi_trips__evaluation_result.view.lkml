
view: taxi_trips__evaluation_result {
  derived_table: {
    sql:
    SELECT * FROM ML.EVALUATE(
      MODEL ${taxi_trips__model.SQL_TABLE_NAME}, (
        SELECT
          CAST(`day` AS TIMESTAMP) ts,
          total_rides
        FROM ${taxi_trips__validation.SQL_TABLE_NAME}
      ),
      STRUCT(TRUE AS perform_aggregation, 30 AS horizon)
    );;
  }

  dimension: mean_absolute_error {
    type: number
    sql: ${TABLE}.mean_absolute_error;;
  }

  dimension: mean_squared_error {
    type: number
    sql: ${TABLE}.mean_squared_error;;
  }

  dimension: root_mean_squared_error {
    type: number
    sql: ${TABLE}.root_mean_squared_error;;
  }

  dimension: mean_absolute_percentage_error {
    type: number
    sql: ${TABLE}.mean_absolute_percentage_error;;
  }

  dimension: symmetric_mean_absolute_percentage_error {
    type: number
    sql: ${TABLE}.symmetric_mean_absolute_percentage_error;;
  }
}
