
view: taxi_trips__validation {
  sql_table_name: `ml.taxi_trips__validation` ;;

  dimension: daily_revenues {
    type: number
    sql: ${TABLE}.daily_revenues ;;
  }

  dimension_group: day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.day ;;
  }

  dimension: total_rides {
    type: number
    sql: ${TABLE}.total_rides ;;
  }

  measure: count {
    type: count
  }
}
