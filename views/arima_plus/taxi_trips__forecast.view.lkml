
view: taxi_trips__forecast {
  derived_table: {
    sql:
    WITH
    forecast_rides AS (
      SELECT
        DATE(forecast_timestamp) AS day,
        CAST(forecast_value AS INT64) AS forecast_rides,
        CAST(prediction_interval_lower_bound AS INT64) AS forecast_rides_lower_bound,
        CAST(prediction_interval_upper_bound AS INT64) AS forecast_rides_upper_bound
      FROM ML.FORECAST(MODEL ${taxi_trips__model.SQL_TABLE_NAME}, STRUCT(30 AS horizon, 0.9 AS confidence_level))
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
      r.day,
      r.total_rides,
      f.forecast_rides,
      f.forecast_rides_lower_bound,
      f.forecast_rides_upper_bound
    FROM real_rides r
    LEFT JOIN forecast_rides f ON r.day = f.day
    ORDER BY day DESC;;
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

  measure: forecast_rides {
    type: sum
    sql: ${TABLE}.forecast_rides ;;
  }

  measure: forecast_rides_lower_bound {
    type: sum
    sql: ${TABLE}.forecast_rides_lower_bound ;;
  }

  measure: forecast_rides_upper_bound {
    type: sum
    sql: ${TABLE}.forecast_rides_upper_bound ;;
  }

  measure: count {
    type: count
  }
}
