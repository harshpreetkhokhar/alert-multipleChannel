variable "policy-condition" {
  type = any
}
# type = list(object({
#   typeofcondition      =string
#   aggregation_window   = number
#   aggregation_method   = string
#   aggregation_delay    = number
#   expiration_duration  = number
#   critical = object({
#     operator               = string
#     threshold_occurrences  = string
#     threshold_duration     = string
#     threshold              = number
#   })
#   warning = object({
#     operator               = string
#     threshold_occurrences  = string
#     threshold_duration     = string
#     threshold              = number
#   })
# }))



# variable "query" {
#   type = string
# }

variable "destination" {
type = any
}
variable "channel" {
type = any
}
# variable "apikey" {
#   type = string
# }

variable "accountID" {
  type = string
}



variable "alert-workflow" {
type = any
}
