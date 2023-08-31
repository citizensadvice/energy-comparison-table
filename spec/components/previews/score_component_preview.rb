# frozen_string_literal: true

class ScoreComponentPreview < ViewComponent::Preview
  def default
    component = ScoreComponent.new(score: 3.5)
    render component
  end

  def highlighted_stars
    component = ScoreComponent.new(score: 4.4, highlight_stars: true)
    render component
  end

  def half_star
    component = ScoreComponent.new(score: 3.8, highlight_stars: true)
    render component
  end

  def with_link
    component = ScoreComponent.new(score: 1, highlight_stars: true).with_content(tag.a("More details", href: "https://www.example.com"))
    render component
  end
end
