# frozen_string_literal: true

class OtherInfoComponent < ViewComponent::Base
  attr_reader :supplier, :renderer

  delegate :contact_details_fragment, to: :helpers

  def initialize(supplier)
    @supplier = supplier
    @renderer = Renderers::RichTextRenderer.new
  end

  def render?
    supplier.present?
  end

  def descriptions
    [
      {
        term: content_tag(:h3, "Fuel Mix"),
        description: fuel_mix
      },
      {
        term: content_tag(:h3, "Contact Information", { id: contact_details_fragment }),
        description: contact_info
      },
      {
        term: content_tag(:h3, "Opening Hours"),
        description: opening_hours
      }
    ].reject { |desc| desc[:description].blank? }
  end

  def contact_info
    renderer.render_with_breaks(supplier.contact_info)
  end

  def opening_hours
    renderer.render_with_breaks(supplier.opening_hours)
  end

  def fuel_mix
    renderer.render_with_breaks(supplier.fuel_mix)
  end
end
