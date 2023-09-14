# frozen_string_literal: true

require "rails_helper"

RSpec.describe OtherScoresComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Other scores" }

  # contact ratings
  it { is_expected.to have_text "Emails responded to within 2 days" }
  it { is_expected.to have_text "89%" }
  it { is_expected.to have_text "Average call centre wait time (hours:minutes)" }
  it { is_expected.to have_text "03:27" }

  # complaints ratings
  it { is_expected.to have_text "Complaints to third parties" }
  it { is_expected.to have_text "172 per 10,000 customers" }

  # bills ratings
  it { is_expected.to have_text "Customers who had an accurate bill at least once a year" }
  it { is_expected.to have_text "99%" }

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.not_to have_selector "body" }
  end
end
