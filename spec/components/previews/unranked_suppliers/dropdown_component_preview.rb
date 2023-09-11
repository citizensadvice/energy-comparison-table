# frozen_string_literal: true

module UnrankedSuppliers
  class DropdownComponentPreview < ViewComponent::Preview
    def default
      render(UnrankedSuppliers::DropdownComponent.new)
    end
  end
end
