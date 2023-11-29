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

resource "snowflake_schema" "demo_schema_new" {
  database = snowflake_database.demo_db.name
  name     = "DEMO_SCHEMA_new"
  comment  = "Schema for Snowflake Terraform demo"
}

resource "snowflake_file_format" "new_file_format" {
  name          = "new_file_format"
  database      = snowflake_database.demo_db.name
  schema        = snowflake_schema.demo_schema_new.name
  format_type   = "CSV"
  field_option  = "FIXED"
  record_delimiter = ","
}

resource "snowflake_table" "s3_integration" {
  name     = "s3_integration"
  database = snowflake_database.demo_db.name
  schema   = snowflake_schema.demo_schema_new.name

  column {
    name    = "column1"
    type    = "TEXT"
  }

  column {
    name    = "column2"
    type    = "NUMBER"
  }

  column {
    name    = "column3"
    type    = "VARCHAR(255)"
  }

  file_format = snowflake_file_format.new_file_format.name
}

