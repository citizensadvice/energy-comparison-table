# frozen_string_literal: true

class ScoreSummaryComponent < ViewComponent::Base
  attr_reader :supplier, :quarter_date

  delegate :scores_fragment, to: :helpers

  def initialize(supplier, quarter_date)
    @supplier = supplier
    @quarter_date = quarter_date
  end

  def render?
    supplier.present?
  end
end
