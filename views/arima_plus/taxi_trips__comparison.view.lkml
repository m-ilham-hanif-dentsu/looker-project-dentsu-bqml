
view: taxi_trips__comparison {
  derived_table: {
    sql:
    WITH
    forecast_rides AS (
      SELECT
        DATE(forecast_timestamp) AS day,
        CAST(forecast_value AS INT64) AS forecast_rides,
        CAST(prediction_interval_lower_bound AS INT64) AS forecast_rides_lower_bound,
        CAST(prediction_interval_upper_bound AS INT64) AS forecast_rides_upper_bound
      FROM ML.FORECAST(MODEL ${taxi_trips__model.SQL_TABLE_NAME}, STRUCT(60 AS horizon, 0.9 AS confidence_level))
    ),
    real_rides AS (
      SELECT
        day,
        total_rides
      FROM ${taxi_trips__training.SQL_TABLE_NAME}

      UNION ALL

      SELECT
      day,
      total_rides
      FROM ${taxi_trips__validation.SQL_TABLE_NAME}
    )
    SELECT
    "data_org" id,
    r.day,
    r.total_rides
    FROM real_rides r

    UNION ALL

    SELECT
    "data_forecast" id,
    f.day,
    f.forecast_rides as total_rides
    FROM forecast_rides f
    WHERE 1=1
    AND f.day not in (
      SELECT DISTINCT day
      FROM real_rides
    )
    ORDER BY day DESC;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension_group: day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.day ;;
  }

  measure: total_rides {
    type: sum
    sql: ${TABLE}.total_rides ;;
  }
}
