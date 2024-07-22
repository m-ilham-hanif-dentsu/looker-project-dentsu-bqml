
view: daily_trx_trend_value__evaluation_result {
  derived_table: {
    sql:
    SELECT * FROM ml.EVALUATE(
      MODEL ${daily_trx_trend_value__model.SQL_TABLE_NAME}, (
        SELECT * FROM ${daily_trx_trend_value__validation_data.SQL_TABLE_NAME}
      )
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

  dimension: mean_squared_log_error {
    type: number
    sql: ${TABLE}.mean_squared_log_error;;
  }

  dimension: median_absolute_error {
    type: number
    sql: ${TABLE}.median_absolute_error;;
  }

  dimension: r2_score {
    type: number
    sql: ${TABLE}.r2_score;;
  }

  dimension: explained_variance {
    type: number
    sql: ${TABLE}.explained_variance;;
  }
}
