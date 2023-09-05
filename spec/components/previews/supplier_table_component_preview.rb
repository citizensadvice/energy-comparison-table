# frozen_string_literal: true

class SupplierTableComponentPreview < ViewComponent::Preview
  def default
    render(SupplierTableComponent.new)
  end
end
