terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=3.40.1"
    }
  }
}

# Configure the New Relic provider
provider "newrelic" {
  # account_id = 449084 #
  # api_key    = var.apikey    # # Secure your API key properly in real scenarios
  # region     = "US"          # Valid regions are US and EU
   account_id = 4495087
  api_key    = "NRAK-16ZO0Z8XD8YICJGY22TZ5NJACIZ"
}


