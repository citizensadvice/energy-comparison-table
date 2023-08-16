# frozen_string_literal: true

module Queries
  Suppliers = Contentful::Graphql::Client.new.parse <<-GRAPHQL
    query {
      energySupplierCollection (
        order:rank_ASC
      ) {
        total,
        items {
          name,
          slug,
          rank,
          previousRank,
          complaintsRating,
          overallRating,
          dataAvailable
        }
      }
    }
  GRAPHQL
end
