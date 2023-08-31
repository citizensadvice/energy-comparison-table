# frozen_string_literal: true

class ScoreComponent < ViewComponent::Base
  renders_one :link

  def initialize(score:, highlight_stars: false)
    @score = score
    @highlight_stars = highlight_stars
  end

  def render?
    @score.present?
  end

  private

  def highlight_stars?
    @highlight_stars
  end

  def round_score?
    !highlight_stars?
  end

  def score_text
    return "#{@score.round} out of 5" if round_score?

    "#{@score.round(2)} out of 5"
  end

  def score_number
    highlight_stars? ? @score.round(1) : @score.round
  end
end
