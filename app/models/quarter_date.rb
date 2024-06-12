# frozen_string_literal: true

class QuarterDate
  include ActiveModel::Model

  attr_accessor :data

  delegate :content_pattern_string_name, :body, to: :data

  def self.fetch_quarter_dates_content(content_id)
    response = Contentful::Graphql::Client.query(
      Queries::QuarterDates,
      variables: { content_id: }
    )

    data = response.data.content_pattern_string_collection&.items.to_a.first

    QuarterDate.new(data:)
  end
end
