# Connection
connection: "dentsu_bqml"

# Datagroup
datagroup: datagroup__refresh_every_hour {
  max_cache_age: "90 minutes"
  interval_trigger: "60 minutes"
  description: "This datagroup will refresh all connected explore every 60m."
}

datagroup: datagroup__refresh_everyday {
  max_cache_age: "36 hours"
  sql_trigger: SELECT CURRENT_DATE("Asia/Jakarta") ;;
  description: "This datagroup will refresh all connected explore everyday."
}

# Explore
# Linear Regression
include: "/views/**/*.view.lkml" # include all views in the views/ folder in this project

explore: daily_trx_trend_value__dataset {
  from: daily_trx_trend_value__dataset
}

explore: daily_trx_trend_value__model {
  persist_with: datagroup__refresh_everyday
  from: daily_trx_trend_value__model
  hidden: yes
}

explore: daily_trx_trend_value__prediction_result {
  from: daily_trx_trend_value__prediction_result
}

explore: daily_trx_trend_value__evaluation_result {
  from: daily_trx_trend_value__evaluation_result
}

# ARIMA
explore: taxi_trips__model {
  persist_with: datagroup__refresh_every_hour
  from: taxi_trips__model
  hidden: yes
}

explore: taxi_trips__arima_evaluation_result {
  from: taxi_trips__arima_evaluation_result
}

explore: taxi_trips__evaluation_result {
  from: taxi_trips__evaluation_result
}

explore: taxi_trips__forecast {
  from: taxi_trips__forecast
}
