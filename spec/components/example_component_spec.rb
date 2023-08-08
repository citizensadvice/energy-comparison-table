# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExampleComponent, type: :component do
  subject { page }

  context "when a title is specified" do
    before do
      render_inline(described_class.new(title: "This is a great title"))
    end

    it { is_expected.to have_text "This is a great title" }
    it { is_expected.to have_text "This is an example view component" }
  end
end
