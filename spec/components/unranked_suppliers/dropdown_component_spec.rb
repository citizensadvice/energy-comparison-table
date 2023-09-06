# frozen_string_literal: true

require "rails_helper"

RSpec.describe UnrankedSuppliers::DropdownComponent, type: :component do
  subject { page }

  let(:suppliers) { build_list(:supplier, 10) }
  let(:chosen_supplier_slug) { nil }

  before do
    render_inline described_class.new(suppliers.presence, chosen_supplier_slug:)
  end

  it { is_expected.to have_text "Find your supplier" }
  it { is_expected.to have_selector "option", count: 11 }
  it { is_expected.to have_text "Please select" }
  it { is_expected.not_to have_selector "option[selected]" }

  context "when a chosen supplier slug is passed" do
    let(:chosen_supplier_slug) { "an-energy-supplier-inc" }

    it { is_expected.to have_selector "option[value*=an-energy-supplier-inc]" }
    it { is_expected.to have_selector "option[selected]" }
  end

  context "when there are no suppliers" do
    let(:suppliers) { nil }

    it { is_expected.not_to have_text "Please select" }
  end
end
