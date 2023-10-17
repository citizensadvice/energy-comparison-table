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
        expect(all_suppliers.map(&:rank).compact).to eql [1, 2, 3, 4, 5, 6, 7]
      end
    end

    describe "#fetch_with_top_three" do
      subject(:supplier_with_top_three) { described_class.fetch_with_top_three(slug) }

      let(:slug) { "smol-energy-inc" }

      around do |example|
        ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
          VCR.use_cassette("supplier/fetch_with_top_three", match_requests_on: [:method]) do
            example.run
          end
        end
      end

      it { is_expected.to be_present }
      its(:size) { is_expected.to be 4 }

      it "returns the requested supplier" do
        expect(supplier_with_top_three.map(&:name)).to include "Smol Energy Inc"
      end

      it "returns the suppliers in order" do
        expect(supplier_with_top_three.map(&:rank)).to eql [1, 2, 3, 6]
      end
    end
  end

  describe "a ranked supplier" do
    subject { build(:supplier, :ranked) }

    its(:name) { is_expected.to eq "An Energy Supplier Inc" }
    its(:slug) { is_expected.to eq "an-energy-supplier-inc" }
    its(:rank) { is_expected.to eq 1 }
    its(:complaints_rating) { is_expected.to eq 4.3 }
    its(:complaints_number) { is_expected.to eq 172 }
    its(:contact_email) { is_expected.to eq 89 }
    its(:contact_rating) { is_expected.to eq 2.3 }
    its(:contact_social_media) { is_expected.to eq "01:15:00" }
    its(:contact_time) { is_expected.to eq "03:27" }
    its(:guarantee_rating) { is_expected.to eq 3 }
    its(:overall_rating) { is_expected.to eq 4.8 }
    its(:id) { is_expected.to eq "an-energy-supplier-inc" }

    it { is_expected.to be_top_three }
    it { is_expected.to be_persisted }
    it { is_expected.to be_ranked }
  end

  describe "an unranked supplier" do
    subject { build(:supplier) }

    its(:rank) { is_expected.to be_nil }
    it { is_expected.not_to be_ranked }
    it { is_expected.not_to be_top_three }
  end
end
