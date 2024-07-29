accountID = 4495087

policy-condition = {
  "0" = {
    typeofcondition       = "static"
    aggregation_window    = 60
    aggregation_method    = "event_flow"
    aggregation_delay     = 120
    expiration_duration   = 120
    operator              = "above"
    threshold_occurrences = "ALL"
    threshold             = 5.5
    threshold_duration    = 300
    operator              = "above"
    threshold_occurrences = "ALL"
    threshold             = 3.5
    threshold_duration    = 600
    query = "SELECT average(duration) FROM Transaction where appName = 'Foodme-test' "
  }
}
alert-workflow = {
  "0"={muting_rules_handling = "NOTIFY_ALL_ISSUES"
  name="wf-1"
  filler-name="filter"
   attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
     

 attribute-1 = "priority"
      operator-1  = "EXACTLY_MATCHES"
     
  }
  # "1"={muting_rules_handling = "NOTIFY_ALL_ISSUES"
  # name="wf-2"
  # filler-name="f-2"
  #     operator  = "EXACTLY_MATCHES"
  #     attribute = "labels.policyIds"
  #     operator-1  = "EXACTLY_MATCHES"
  #     attribute-1 = "priority"
  # }
  }



destination = {
  "0" = {property-key           = "email"
  name="dest-1"
typeofdestination      = "EMAIL"
property-value         = "kharshpreet13@gmail.com"}
"1"={
  property-key           = "url"
   name="dest-2"
typeofdestination      = "WEBHOOK"
property-value         = "https://webhook.site/e10ba2b8-3539-42b6-84d8-d7216a91606e"
}
}
channel={"0"={
  channel-type           = "EMAIL"
  name="channel-1"
channel-product        = "IINT"
channel-property-key   = "alert"
channel-property-value = "transaction took too longg"
}
"1"={
  channel-type           = "WEBHOOK"
   name="channel-1"
channel-product        = "IINT"
channel-property-key   = "payload"
channel-property-value = "{{ json incidentIds }}"
}
}







