# frozen_string_literal: true

require "rails_helper"

RSpec.describe SupplierTableRowComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "1" }
  it { is_expected.to have_text "An Energy Supplier Inc" }
  it { is_expected.to have_selector ".stars", count: 4 }
  it { is_expected.to have_selector ".stars--highlight", count: 1 }
  it { is_expected.to have_link "More details", href: "#{CSR_APP_PATH}an-energy-supplier-inc/details" }
end
