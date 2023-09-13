# frozen_string_literal: true

class ScoreSummaryComponent < ViewComponent::Base
  attr_reader :supplier

  def initialize(supplier)
    @supplier = supplier
  end

  def render?
    supplier.present?
  end

  def rank_text
    "#{supplier.name} ranked #{supplier.rank.ordinalize} in the supplier comparison table"
  end
end
