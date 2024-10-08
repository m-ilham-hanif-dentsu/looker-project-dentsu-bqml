
view: taxi_trips__arima_evaluation_result {
  derived_table: {
    sql:
    SELECT * EXCEPT(SEASONAL_PERIODS)
    FROM ML.ARIMA_EVALUATE (MODEL ${taxi_trips__model.SQL_TABLE_NAME}),
         UNNEST(SEASONAL_PERIODS) as seasonal_periods_str;;
  }

  dimension: non_seasonal_p {
    type: number
    sql: ${TABLE}.non_seasonal_p;;
  }

  dimension: non_seasonal_d {
    type: number
    sql: ${TABLE}.non_seasonal_d;;
  }

  dimension: non_seasonal_q {
    type: number
    sql: ${TABLE}.non_seasonal_q;;
  }

  dimension: has_drift {
    type: yesno
    sql: ${TABLE}.has_drift;;
  }

  dimension: log_likelihood {
    type: number
    sql: ${TABLE}.log_likelihood;;
  }

  dimension: aic {
    type: number
    sql: ${TABLE}.aic;;
  }

  dimension: variance {
    type: number
    sql: ${TABLE}.variance;;
  }

  dimension: seasonal_periods_str {
    type: string
    sql: ${TABLE}.seasonal_periods_str;;
  }

  dimension: has_holiday_effect {
    type: yesno
    sql: ${TABLE}.has_holiday_effect;;
  }

  dimension: has_spikes_and_dips {
    type: yesno
    sql: ${TABLE}.has_spikes_and_dips;;
  }

  dimension: has_step_changes {
    type: yesno
    sql: ${TABLE}.has_step_changes;;
  }

  dimension: error_message {
    type: string
    sql: ${TABLE}.error_message;;
  }
}
