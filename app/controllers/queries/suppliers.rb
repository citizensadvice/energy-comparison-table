# frozen_string_literal: true

module Queries
  Suppliers = Contentful::Graphql::Client.parse <<-GRAPHQL
    query {
      energySupplierCollection {
        items {
          name,
          rank,
          overallRating
        }
      }
    }
  GRAPHQL
end
