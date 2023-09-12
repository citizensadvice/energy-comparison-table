# frozen_string_literal: true

class DescriptionListComponent < ViewComponent::Base
  renders_one :title
  renders_many :descriptions, "DescriptionComponent"

  def render?
    descriptions?
  end

  class DescriptionComponent < ViewComponent::Base
    attr_reader :term, :description

    def initialize(term:, description:)
      @term = term
      @description = description
    end
  end
end
