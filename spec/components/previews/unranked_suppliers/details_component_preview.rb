# frozen_string_literal: true

class UnrankedSuppliers::DetailsComponentPreview < ViewComponent::Preview
  def default
    render(UnrankedSuppliers::DetailsComponent.new)
  end
end
