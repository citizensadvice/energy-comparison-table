# frozen_string_literal: true

require "factory_bot_rails"

class SupplierTableComponentPreview < ViewComponent::Preview
  include FactoryBot::Syntax::Methods

  def default
    suppliers = build_list(:supplier, 10)

    render(SupplierTableComponent.new(suppliers))
  end
end
