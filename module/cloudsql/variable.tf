variable "project_name" {
  type        = string
  default     = "terraform-project-sarvar89" #that yellow part 
  description = "enter your project name"
}


variable "region" {
  type        = string
  default     = "us-central1"
  description = "add desired region"
}


variable "zone" {
  type        = string
  default     = "us-central1"
  description = "zone where to deploy resource"
}




variable "data_base_version" {
  type        = string
  default     = "MYSQL_5_7" #MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6,POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB
  description = "specifies the database version"
}


variable "db_password" {
  type        = string
  default     = "mydbppassword"
  description = "description"
}

variable "db_username" {
  type        = string
  default     = "diana"
  description = "input the database authorized user "
}

variable "db_host" {
  type        = string
  default     = "%"
  description = "description"

}

variable "db_name" {
  type        = string
  default     = "wordpress"
  description = "description"
}


# in this folder only top code block was changed

# variable "project_name" {
#   type        = string
#   default     = "terraform-project-kani95" #that yellow part 
#   description = "enter your project name"
# }
