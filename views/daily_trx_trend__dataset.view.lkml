
view: daily_trx_trend_value__dataset {
  # sql_table_name: `ml.daily_trx_trend_value` ;;
  derived_table: {
    sql:
    SELECT `Date` as dt, cast(`Open` as float64) value FROM `ml.exxon_stock`
    WHERE 1=1
    and `Date` >= '2024-01-01'
    ORDER BY 1 DESC;;
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
