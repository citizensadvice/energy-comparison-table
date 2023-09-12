# frozen_string_literal: true

require "rails_helper"

RSpec.describe DescriptionListComponent, type: :component do
  subject { page }

  let(:title) { "Description list title" }
  let(:descriptions) do
    [
      {
        term: "First term",
        description: "First term description"
      },
      {
        term: "Second term",
        description: "Second term description"
      }
    ]
  end

  before do
    render_inline described_class.new do |c|
      c.with_title do
        title
      end
      c.with_descriptions(descriptions)
    end
  end

  it { is_expected.to have_text "Description list title" }
  it { is_expected.to have_selector "dt", count: 2 }
  it { is_expected.to have_selector "dt", text: "First term" }
  it { is_expected.to have_selector "dt", text: "Second term" }
  it { is_expected.to have_selector "dd", count: 2 }
  it { is_expected.to have_selector "dd", text: "First term description" }
  it { is_expected.to have_selector "dd", text: "Second term description" }

  context "when no descriptions are provided" do
    before do
      render_inline described_class.new do |c|
        c.with_title do
          title
        end
      end
    end

    it { is_expected.not_to have_selector "body" }
  end
end
