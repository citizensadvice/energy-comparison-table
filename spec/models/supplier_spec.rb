# frozen_string_literal: true

require "rails_helper"
require "pry"

RSpec.describe(Supplier) do
  describe "class methods" do
    describe "#fetch_all" do
      subject(:all_suppliers) { described_class.fetch_all }

      around do |example|
        ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
          VCR.use_cassette("supplier/fetch_all", match_requests_on: [:method]) do
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

  describe "a ranked supplier" do
    subject { build(:supplier, :ranked) }

    its(:name) { is_expected.to eq "An Energy Supplier Inc" }
    its(:slug) { is_expected.to eq "an-energy-supplier-inc" }
    its(:rank) { is_expected.to eq 1 }
    its(:previous_rank) { is_expected.to eq 2 }
    its(:complaints_rating) { is_expected.to eq 4 }
    its(:overall_rating) { is_expected.to eq 5 }
    its(:id) { is_expected.to eq "an-energy-supplier-inc" }

    it { is_expected.to be_persisted }
    it { is_expected.to be_ranked }
  end

  describe "an unranked supplier" do
    subject { build(:supplier) }

    its(:rank) { is_expected.to be_nil }
    it { is_expected.not_to be_ranked }
  end
end
