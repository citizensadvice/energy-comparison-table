# frozen_string_literal: true

FactoryBot.define do
  # Use the Hashie::Mash class to mock the data we get back from Contentful
  # See https://www.rubydoc.info/gems/hashie/Hashie/Mash
  factory :supplier_data, class: "Hashie::Mash" do
    name { "An Energy Supplier Inc" }
    slug { "an-energy-supplier-inc" }
    id { slug }
    data_available { false }
    contact_info { { json: JSON.parse(File.read("spec/fixtures/contact_info.json")) } }
    billing_info { { json: JSON.parse(File.read("spec/fixtures/billing_info.json")) } }
    opening_hours { { json: JSON.parse(File.read("spec/fixtures/opening_hours.json")) } }
    fuel_mix { { json: JSON.parse(File.read("spec/fixtures/fuel_mix.json")) } }

    trait :ranked do
      data_available { true }
      rank { 1 }
      previous_rank { 2 }
      complaints_rating { 4.3 }
      complaints_number { 172 }
      contact_rating { 2.3 }
      contact_time { "03:27" }
      contact_email { 89 }
      bills_rating { 3.4 }
      bills_accuracy { 99 }
      overall_rating { 4.8 }
    end

    trait :missing_fuel_mix do
      fuel_mix { nil }
    end

    trait :whitelabelled do
      whitelabel_supplier { { name: "White Label Energy Inc" } }
    end
  end

  factory :supplier, class: "Supplier" do
    data  factory: :supplier_data

    trait(:ranked) do
      data factory: %i[supplier_data ranked]
    end

    trait(:whitelabelled) do
      data factory: %i[supplier_data whitelabelled]
    end

    trait(:missing_fuel_mix) do
      data factory: %i[supplier_data missing_fuel_mix]
    end
  end
end
