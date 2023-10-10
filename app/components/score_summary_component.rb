# frozen_string_literal: true

class ScoreSummaryComponent < ViewComponent::Base
  attr_reader :supplier

  def initialize(supplier)
    @supplier = supplier
  end

  def render?
    supplier.present?
  end
end
