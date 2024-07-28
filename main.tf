// entities
data "newrelic_entity" "app" {
  name   = "Foodme-test"
  domain = "APM"
  type   = "APPLICATION"
  tag {
    key   = "accountId"
    value = var.accountID
  }
}

resource "newrelic_alert_policy" "Policy1" {
  name = "tf-policy-2wf"
}

resource "newrelic_nrql_alert_condition" "condition" {
  for_each    = var.policy-condition
  account_id  = var.accountID
  policy_id   = newrelic_alert_policy.Policy1.id
  type        = each.value.typeofcondition
  name        = "tf-condition"
  description = "Alert when transactions are taking too long"
  #   runbook_url                    = "https://www.example.com"
  enabled = true
  #   violation_time_limit_seconds   = 3600
  #   fill_option                    = "static"
  #   fill_value                     = 0
  aggregation_window  = each.value.aggregation_window
  aggregation_method  = each.value.aggregation_method
  aggregation_delay   = each.value.aggregation_delay
  expiration_duration = each.value.expiration_duration
  #   open_violation_on_expiration   = true
  #   close_violations_on_expiration = true
  slide_by = 30

  nrql {
    query = each.value.query
  }

  critical {
    operator              = each.value.operator
    threshold             = each.value.threshold
    threshold_duration    = each.value.threshold_duration
    threshold_occurrences = each.value.threshold_occurrences
  }

  warning {
    operator              = each.value.operator
    threshold             = each.value.threshold
    threshold_duration    = each.value.threshold_duration
    threshold_occurrences = each.value.threshold_occurrences
  }
}
resource "newrelic_workflow" "workflow" {
  for_each              = var.alert-workflow
  name                  = each.value.name
  muting_rules_handling = each.value.muting_rules_handling

  issues_filter {
    name = each.value.filler-name
    type = "FILTER"

    predicate {
      attribute = each.value.attribute
      operator  = each.value.operator
      values    = [newrelic_alert_policy.Policy1.id]
    }
    predicate {
      attribute = each.value.attribute-1
      operator  = each.value.operator-1
      values    = ["HIGH"]
    }
  }

  # destination {
  #   channel_id = newrelic_notification_channel.channel[each.key].id
  # }
  dynamic "destination" {
    for_each = var.channel
    content {
      channel_id = newrelic_notification_channel.channel[destination.key].id
    }
  }

}
resource "newrelic_notification_destination" "mailpoint" {
  for_each = var.destination
  account_id = var.accountID
  name       = each.value.name
  type       = each.value.typeofdestination

  property {
    key   = each.value.property-key
    value = each.value.property-value
  }
}
resource "newrelic_notification_channel" "channel" {
  for_each = var.channel
  account_id     = var.accountID
  name           = each.value.name
  type           = each.value.channel-type
  destination_id = newrelic_notification_destination.mailpoint[each.key].id
  product        = each.value.channel-product // (Workflows)


  property {
    key   = each.value.channel-property-key
    value = each.value.channel-property-value
  }
}