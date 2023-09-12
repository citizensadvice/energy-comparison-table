# frozen_string_literal: true

module Queries
  SupplierDetail = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($tag_filter: ContentfulMetadataTagsFilter, $slug: String) {
    energySupplierCollection (
      order:rank_ASC,
      where: {
        contentfulMetadata:{ tags: $tag_filter },
        OR: [
        	{slug: $slug},
          {rank_in: [1, 2, 3]}
        ]
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
