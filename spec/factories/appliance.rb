# frozen_string_literal: true

FactoryBot.define do
  # Use the Hashie::Mash class to mock the data we get back from Contentful
  # See https://www.rubydoc.info/gems/hashie/Hashie/Mash
  factory :appliance_data, class: "Hashie::Mash" do
    name { "A test appliance" }
    category { "Test group" }
    wattage { 1000 }
    usage_type { "Time" }
    sys do
      { id: "contentful-id-1234" }
    end

    trait :cyclical do
      usage_type { "Cycles" }
    end

    trait :with_additional_usage do
      additional_usage { 10 }
    end
  end

  factory :appliance, class: "Appliance" do
    data  factory: :appliance_data

    trait(:cyclical) do
      data factory: %i[appliance_data cyclical]
    end

    trait(:with_additional_usage) do
      data factory: %i[appliance_data with_additional_usage]
    end
  end
end
