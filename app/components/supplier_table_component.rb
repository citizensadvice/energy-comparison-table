# frozen_string_literal: true

class SupplierTableComponent < ViewComponent::Base
  attr_reader :suppliers, :highlight_supplier_with_slug

  def initialize(suppliers, highlight_supplier_with_slug: nil)
    @suppliers = suppliers
    @highlight_supplier_with_slug = highlight_supplier_with_slug
  end
end
