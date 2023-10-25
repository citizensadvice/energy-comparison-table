# frozen_string_literal: true

class FuelMixComponent < ViewComponent::Base
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
        term: content_tag(:h3, ""),
        description: fuel_mix
      }
    ].reject { |desc| desc[:description].blank? }
  end

  def fuel_mix
    renderer.render_without_breaks(supplier.fuel_mix)
  end
end
