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
resource "snowflake_file_format" "demo" {
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema.name
  name     = "DEMO_FILE_FORMAT"
  
  type                = "CSV"
  field_optionally_enclosed_by = '"'
  compression         = "GZIP"
  record_delimiter    = "\n"
  field_delimiter     = ","
  skip_header         = 1
  date_format         = "AUTO"
  time_format         = "AUTO"
  timestamp_format    = "AUTO"
  binary_format       = "BASE64"
  escape              = "\\"
  escape_unenclosed_field = "\\"
  trim_space          = false
  field_optionally_enclosed_by = ""
  null_if             = ["NULL"]
  error_on_column_count_mismatch = false
  validate_utf8       = false
  skip_byte_order_mark = false
  encoding            = "UTF8"
  comment             = "File Format for Snowflake Terraform demo"
}
