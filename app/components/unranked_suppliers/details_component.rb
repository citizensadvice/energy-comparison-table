# frozen_string_literal: true

module UnrankedSuppliers
  class DetailsComponent < ViewComponent::Base
    attr_reader :renderer, :supplier

    def initialize(supplier)
      @supplier = supplier
      @renderer = Renderers::RichTextRenderer.new
    end

    def render?
      @supplier.present?
    end

    def title
      return @supplier.name unless whitelabelled?

      if Feature.enabled? "FF_SMALL_SUPPLIER_STARS"
        "#{supplier.whitelabel_supplier.name} provides energy and customer service for #{@supplier.name}"
      else
        "#{supplier.whitelabel_supplier.name} provides energy for #{@supplier.name}"
      end
    end

    def whitelabel_supplier_link
      return unless whitelabelled?

      return unless Feature.enabled? "FF_SMALL_SUPPLIER_STARS"

      link_to(link_text, supplier_path(supplier.whitelabel_supplier.name.parameterize, { country: @current_country }))
    end

    def whitelabelled?
      @supplier.whitelabel_supplier.present?
    end

    def descriptions
      [
        {
          term: content_tag(:h4, "Contact information"),
          description: contact_info
        },
        {
          term: content_tag(:h4, "Opening hours"),
          description: opening_hours
        },
        {
          term: content_tag(:h4, "Billing information"),
          description: billing_info
        },
        {
          term: content_tag(:h4, "Fuel mix"),
          description: fuel_mix
        }
      ].reject { |desc| desc[:description].blank? }
    end

    def contact_info
      renderer.render_with_breaks(supplier.contact_info)
    end

    def billing_info
      renderer.render_with_breaks(supplier.billing_info)
    end

    def opening_hours
      renderer.render_with_breaks(supplier.opening_hours)
    end

    def fuel_mix
      renderer.render_with_breaks(supplier.fuel_mix)
    end

    def supplier_name
      @supplier.name
    end

    def link_text
      "Check the #{supplier.whitelabel_supplier.name} results to see how they rate."
    end
  end
end
