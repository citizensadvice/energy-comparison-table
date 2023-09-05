# frozen_string_literal: true

class ScoreComponentPreview < ViewComponent::Preview
  def default
    component = ScoreComponent.new(score: 3.5)
    render component
  end

  def highlighted_stars
    component = ScoreComponent.new(score: 4.4, show_decimal_score: true)
    render component
  end

  def half_star
    component = ScoreComponent.new(score: 3.8, show_decimal_score: true)
    render component
  end

  def not_scored
    component = ScoreComponent.new(score: -2)
    render component
  end

  def with_link
    component = ScoreComponent.new(score: 1, show_decimal_score: true).with_content(tag.a("More details", href: "https://www.example.com"))
    render component
  end
end
