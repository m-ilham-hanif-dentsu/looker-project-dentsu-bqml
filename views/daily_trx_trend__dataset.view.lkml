
view: daily_trx_trend_value__dataset {
  derived_table: {
    sql:
SELECT `date` AS dt, `meantemp` AS value FROM `ml.daily_climate__training_data`
UNION ALL
SELECT `date` AS dt, `meantemp` AS value FROM `ml.daily_climate__validation_data`
ORDER BY 1;;
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

  set: detail {
    fields: [
      dt
    ]
  }
}
