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
        term: content_tag(:h3, "Emails responded to within 2 days"),
        description: contact_description
      },
      {
        term: content_tag(:h3, "Complaints to third parties"),
        description: complaints_description
      },
      {
        term: content_tag(:h3, "Average call centre wait time (hours:minutes)"),
        description: contact_time_description
      },
      {
        term: content_tag(:h3, "Customers who had an accurate bill at least once a year"),
        description: bills_description
      }
    ]
  end

  def contact_description
    build_description("#{supplier.contact_email}%", score: supplier.contact_rating)
  end

  def complaints_description
    build_description("#{supplier.complaints_number} per 10,000 customers", score: supplier.complaints_rating.round)
  end

  def contact_time_description
    build_description(supplier.contact_time)
  end

  def bills_description
    build_description("#{supplier.bills_accuracy}%", score: supplier.bills_rating)
  end

  def build_description(text, score: nil)
    content = content_tag(:p, text)
    content << content_tag(:p, "#{score} / 5") if score.present?
    content
  end
end
