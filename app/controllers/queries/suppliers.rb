# frozen_string_literal: true

module Queries
  Suppliers = Contentful::Graphql::Client.new.parse <<-GRAPHQL
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
