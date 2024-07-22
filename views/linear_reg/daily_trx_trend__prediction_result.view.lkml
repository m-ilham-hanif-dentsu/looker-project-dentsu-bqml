
view: daily_trx_trend_value__prediction_result {
  derived_table: {
    sql: SELECT * FROM ml.PREDICT(
        MODEL ${daily_trx_trend_value__model.SQL_TABLE_NAME}, (
            SELECT * FROM ${daily_trx_trend_value__validation_data.SQL_TABLE_NAME}
        )
    );;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dt {
    type: date
    datatype: date
    sql: ${TABLE}.dt ;;
  }

  measure: value {
    type: sum
    sql: ${TABLE}.value ;;
  }

  measure: predicted_value {
    type: sum
    sql: ${TABLE}.predicted_value ;;
  }

  set: detail {
    fields: [
      dt
    ]
  }
}
