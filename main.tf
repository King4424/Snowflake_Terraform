terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "Snowflake_new"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "snowflake" {
}

resource "snowflake_database" "demo_db" {
  name    = "DEMO_DB"
  comment = "Database for Snowflake Terraform demo"
}
resource "snowflake_schema" "demo_schema" {
  database = snowflake_database.demo_db.name
  name     = "DEMO_SCHEMA"
  comment  = "Schema for Snowflake Terraform demo"
}
resource "snowflake_table" "sensor" {
  provider = snowflake
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema.name
  name     = "WEATHER_JSON"
  column {
    name    = "var"
    type    = "VARIANT"
    comment = "Raw sensor data"
  }
}
resource "snowflake_file_format" "json_format" {
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema.name
  name     = "JSON_FORMAT"
  strip_outer_array    = true
  compression          = "NONE"
  binary_format        = "HEX"
  date_format          = "AUTO"
  time_format          = "AUTO"
  timestamp_format     = "AUTO"
  skip_byte_order_mark = true
  type = "JSON"
}

resource "snowflake_stage" "snowstage" {
  database   = snowflake_database.demo_db.name
  schema     = snowflake_schema.demo_schema.name
  name       = "SNOWPIPE_STAGE"
  file_format = snowflake_file_format.json_format.name
}
