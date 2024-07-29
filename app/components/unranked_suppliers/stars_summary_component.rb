# frozen_string_literal: true

module UnrankedSuppliers
  class StarsSummaryComponent < ViewComponent::Base
    attr_reader :supplier

    def initialize(supplier)
      @supplier = supplier
    end

    def render?
      supplier.present?
    end
  end
end
