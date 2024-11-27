# frozen_string_literal: true

module Queries
  Appliances = Contentful::Graphql::Client.parse <<-GRAPHQL
  query {
    applianceCollection {
      items {
        name
        category
        wattage
        usageType
        additionalUsage
        sys {
          id
        }
      }
    }
  }
  GRAPHQL
end
