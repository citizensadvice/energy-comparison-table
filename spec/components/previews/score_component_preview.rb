# frozen_string_literal: true

class ScoreComponentPreview < ViewComponent::Preview
  def default
    component = ScoreComponent.new(score: 3.5)
    render component
  end

  def highlighted_stars
    component = ScoreComponent.new(score: 4, highlight_stars: true)
    render component
  end

  def decimal_score
    component = ScoreComponent.new(score: 3.4, round_score: false)
    render component
  end

  def half_star
    component = ScoreComponent.new(score: 3.8, round_score: false)
    render component
  end
end
