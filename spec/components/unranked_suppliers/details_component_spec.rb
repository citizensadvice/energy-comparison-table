# frozen_string_literal: true

require "rails_helper"

RSpec.describe UnrankedSuppliers::DetailsComponent, type: :component do
  before do
    render_inline described_class.new(build(:supplier))
  end

  # title
  it { is_expected.to have_text "An Energy Supplier Inc" }

  # content from Contentful
  it { is_expected.to have_text "some contact details" }
  it { is_expected.to have_text "some more" }
  it { is_expected.to have_selector "br" }
  it { is_expected.to have_text "opening hours content" }
  it { is_expected.to have_text "fuel mix content" }
  it { is_expected.to have_text "billing info content" }

  # description terms
  it { is_expected.to have_text "Billing information" }
  it { is_expected.to have_text "Opening hours" }
  it { is_expected.to have_text "Fuel mix" }
  it { is_expected.to have_text "Contact information" }

  context "when a supplier does not have some information" do
    before do
      render_inline described_class.new(build(:supplier, :missing_fuel_mix))
    end

    it { is_expected.not_to have_text "Fuel mix" }
    it { is_expected.not_to have_text "fuel mix content" }
  end

  context "when a supplier is whitelabelled" do
    before do
      render_inline described_class.new(build(:supplier, :whitelabelled))
    end

    it { is_expected.to have_text "White Label Energy Inc provides energy for An Energy Supplier Inc" }
  end

  context "when no supplier is present" do
    before do
      render_inline described_class.new(nil)
    end

    it { is_expected.not_to have_selector "body" }
  end
end
