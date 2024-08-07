# frozen_string_literal: true

require "rails_helper"

RSpec.describe HeaderComponent, type: :component do
  subject { page }

  let(:component) { described_class.new }

  describe "common elements" do
    before { render_inline component }

    it { is_expected.to have_link "Citizens Advice Homepage", href: "https://www.citizensadvice.org.uk" }
    it { is_expected.to have_css "[action='https://www.citizensadvice.org.uk/s']" }
  end
end
