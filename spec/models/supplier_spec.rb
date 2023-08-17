# frozen_string_literal: true

require "rails_helper"
require "pry"

RSpec.describe(Supplier) do
  describe "#fetch_all" do
    subject(:all_suppliers) { described_class.fetch_all }

    around do |example|
      ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
        VCR.use_cassette("supplier/fetch_all") do
          example.run
        end
      end
    end

    it { is_expected.to be_present }

    it "returns ranked suppliers in ascending rank order" do
      expect(all_suppliers.first.rank < all_suppliers.second.rank).to be true
    end
  end
end
