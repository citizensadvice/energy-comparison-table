# frozen_string_literal: true

module UnrankedSuppliers
  class DropdownComponent < ViewComponent::Base
    def initialize(suppliers, chosen_supplier_slug: nil)
      @suppliers = suppliers
      @chosen_supplier_slug = chosen_supplier_slug
    end

    def render?
      @suppliers.present?
    end

    def call
      render Input::SelectComponent.new(**select_params)
    end

    private

    def supplier_options
      options = [["Please select", nil]]
      options + @suppliers.map do |supplier|
        [
          supplier.name,
          supplier.slug
        ]
      end
    end

    def select_params
      {
        select_options: supplier_options,
        label: "Select your supplier",
        name: "id",
        type: nil,
        options: {
          value: @chosen_supplier_slug
        }
      }
    end
  end
end
