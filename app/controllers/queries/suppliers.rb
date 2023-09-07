# frozen_string_literal: true

module Queries
  Suppliers = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($tag_filter: ContentfulMetadataTagsFilter) {
    energySupplierCollection (
      order:rank_ASC,
      where: {
        contentfulMetadata:{ tags: $tag_filter }
      }
    ) {
      total,
      items {
        name,
        whitelabelSupplier {
          name
        },
        slug,
        rank,
        previousRank,
        complaintsRating,
        complaintsNumber,
        contactEmail,
        contactRating,
        contactTime,
        billsRating,
        billsAccuracy,
        overallRating,
        dataAvailable,
        contactInfo {
          json
        },
        billingInfo {
          json
        },
        fuelMix {
          json
        },
        openingHours {
          json
        }
      }
    }
  }
  GRAPHQL
end
