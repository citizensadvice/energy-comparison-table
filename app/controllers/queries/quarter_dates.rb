# frozen_string_literal: true

module Queries
  QuarterDates = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($content_name: String!, $preview: Boolean = false) {
    contentPatternStringCollection (
      where: {
        contentPatternStringName: $content_name
      },
      preview: $preview
    ) {
      items {
        contentPatternStringName,
        body,
        sys {
          id
        }
      }
    }
  }
  GRAPHQL
end
