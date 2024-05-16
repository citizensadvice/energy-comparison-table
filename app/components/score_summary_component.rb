# frozen_string_literal: true

class ScoreSummaryComponent < ViewComponent::Base
  attr_reader :supplier

  delegate :scores_fragment, to: :helpers

  def initialize(supplier)
    @supplier = supplier
  end

  def render?
    supplier.present?
  end
end
