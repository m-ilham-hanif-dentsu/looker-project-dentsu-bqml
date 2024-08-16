
view: daily_trx_trend_value__model {
  derived_table: {
    sql_create:
    CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
    OPTIONS (
        model_type = "LINEAR_REG",
        data_split_method = "NO_SPLIT",
        input_label_cols = ['value']
    ) AS
    SELECT dt, value FROM ${daily_trx_trend_value__training_data.SQL_TABLE_NAME};;
    datagroup_trigger: datagroup__refresh_everyday
  }
}
