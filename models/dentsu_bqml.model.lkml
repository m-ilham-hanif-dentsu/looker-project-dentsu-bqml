# Connection
connection: "dentsu_bqml"

# Datagroup
# Set max_cache_age to 0 minutes, with PDT table refreshed every 10 minutes.
# If max_cache_age > interval_trigger, then whenever a new PDT table is created, it wont refer to
#  the newest table. Instead, it will wait until cache age expired before using the new table.
datagroup: datagroup__daily_trx_trend_value__model {
  max_cache_age: "0 minutes"
  interval_trigger: "10 minutes"
  description: "This datagroup will refresh all connected table every 10m."
}

# Explore (data model)
include: "/views/*.view.lkml" # include all views in the views/ folder in this project

explore: daily_trx_trend_value__dataset {
  from: daily_trx_trend_value__dataset
}

explore: daily_trx_trend_value__model {
  persist_with: datagroup__daily_trx_trend_value__model
  from: daily_trx_trend_value__model
}

explore: daily_trx_trend_value__prediction_result {
  from: daily_trx_trend_value__prediction_result
}

explore: daily_trx_trend_value__evaluation_result {
  from: daily_trx_trend_value__evaluation_result
}
