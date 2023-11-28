# frozen_string_literal: true

class OtherScoresComponent < ViewComponent::Base
  attr_reader :supplier, :renderer

  delegate :scores_fragment, to: :helpers

  def initialize(supplier)
    @supplier = supplier
    @renderer = Renderers::RichTextRenderer.new
  end

  def render?
    supplier.present?
  end

  def descriptions
    [
      guarantee_list,
      complaints_number,
      contact_time,
      contact_social_media,
      contact_email
    ]
  end

  def guarantee_list
    {
      term: content_tag(:h3, "Customer guarantees"),
      description: content_tag(:p, guarantee_list_render)
    }
  end

  def complaints_number
    {
      term: content_tag(:h3, "Complaints to Citizens Advice and the Energy Ombudsman"),
      description: content_tag(:p, "#{supplier.complaints_number} per 10,000 customers")
    }
  end

  def contact_time
    {
      term: content_tag(:h3, "Average call centre wait time (hours, minutes and seconds)"),
      description: content_tag(:p, supplier.contact_time)
    }
  end

  def contact_social_media
    {
      term: content_tag(:h3, "Average response time to social media messages (hours, minutes and seconds)"),
      description: content_tag(:p, supplier.contact_social_media)
    }
  end

  def contact_email
    {
      term: content_tag(:h3, "Emails responded to within 2 days"),
      description: content_tag(:p, "#{supplier.contact_email}%")
    }
  end

  def guarantee_list_render
    renderer.render_with_breaks(supplier.guarantee_list)
  end
end
