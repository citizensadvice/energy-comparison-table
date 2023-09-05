# frozen_string_literal: true

class SupplierTableRowComponent < ViewComponent::Base
  attr_reader :supplier
  
  def initialize(supplier)
    @supplier = supplier
  end
end
