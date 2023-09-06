# frozen_string_literal: true

class SupplierTableComponent < ViewComponent::Base
  attr_reader :suppliers

  def initialize(suppliers)
    @suppliers = suppliers
  end
end
