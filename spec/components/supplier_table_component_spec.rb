# frozen_string_literal: true

require "rails_helper"

RSpec.describe SupplierTableComponent, type: :component do
  subject { page }

  let(:suppliers) { build_list(:supplier, 10, :ranked) }

  before do
    render_inline described_class.new(suppliers)
  end

  it { is_expected.to have_selector :table, count: 1 }
  it { is_expected.to have_selector :row, count: 11 }
  it { is_expected.to have_selector :columnheader, "Rank" }
  it { is_expected.to have_selector :columnheader, "Supplier" }
  it { is_expected.to have_selector :columnheader, "Fewer complaints" }
  it { is_expected.to have_selector :columnheader, "Response time" }
  it { is_expected.to have_selector :columnheader, "Bill accuracy" }
  it { is_expected.to have_selector :columnheader, "Overall rating" }
end
