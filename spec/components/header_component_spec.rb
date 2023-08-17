# frozen_string_literal: true

require "rails_helper"

RSpec.describe HeaderComponent, type: :component do
  subject { page }

  let(:component) { described_class.new }

  describe "common elements" do
    before { render_inline component }

    it { is_expected.to have_selector "a[title='Citizens Advice Homepage']" }
    it { is_expected.to have_link "a[href='https://www.citizensadvice.org.uk']" }
    it { is_expected.to have_selector "[action='https://www.citizensadvice.org.uk/s']" }
  end
end
