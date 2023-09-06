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
          supplier_detail_path(supplier.slug)
        ]
      end
    end

    def select_params
      {
        select_options: supplier_options,
        label: "Find your supplier",
        name: "unranked-supplier",
        type: nil,
        options: {
          value: supplier_detail_path(@chosen_supplier_slug)
        }
      }
    end

    def supplier_detail_path(supplier_slug)
      supplier_path(supplier_slug)
    rescue ActionController::UrlGenerationError
      # if no supplier is chosen we can just handle the specific error and return nil as the path
      nil
    end
  end
end
