# frozen_string_literal: true

module Queries
  QuarterDates = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($content_id: String!, $preview: Boolean = false) {
    contentPatternStringCollection (
      where: {
        sys: {
          id: $content_id
        }
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
