# frozen_string_literal: true

FactoryBot.define do
  # Use the Hashie::Mash class to mock the data we get back from Contentful
  # See https://www.rubydoc.info/gems/hashie/Hashie/Mash
  factory :quarter_date_data, class: "Hashie::Mash" do
    content_pattern_string_name { "Energy CSR quarter dates" }
    body { "October to December 2023" }
  end

  factory :quarter_date, class: "QuarterDate" do
    data factory: :quarter_date_data
  end
end
