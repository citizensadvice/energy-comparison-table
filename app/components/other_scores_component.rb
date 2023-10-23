# frozen_string_literal: true

class OtherScoresComponent < ViewComponent::Base
  attr_reader :supplier

  delegate :scores_fragment, to: :helpers

  def initialize(supplier)
    @supplier = supplier
  end

  def render?
    supplier.present?
  end

  def descriptions
    [
      {
        term: content_tag(:h3, "Customer guarantees"),
        description: content_tag(:p, "#{supplier.guarantee_list}%")
      },
      {
        term: content_tag(:h3, "Emails responded to within 2 days"),
        description: content_tag(:p, "#{supplier.contact_email}%")
      },
      {
        term: content_tag(:h3, "Complaints to Citizens Advice and the Energy Ombudsman"),
        description: content_tag(:p, "#{supplier.complaints_number} per 10,000 customers")
      },
      {
        term: content_tag(:h3, "Average call centre wait time (minutes:seconds)"),
        description: content_tag(:p, supplier.contact_time)
      }
    ]
  end
end
