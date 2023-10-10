# frozen_string_literal: true

require "rails_helper"

RSpec.describe ScoreSummaryComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "An Energy Supplier Inc ratings for July to September 2023" }
  it { is_expected.to have_selector ".stars", count: 4 }

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.not_to have_selector "body" }
  end
end
