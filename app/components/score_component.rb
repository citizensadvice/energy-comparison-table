# frozen_string_literal: true

class ScoreComponent < ViewComponent::Base
  renders_one :link

  def initialize(score:, highlight_stars: false, round_score: true)
    @score = score
    @highlight_stars =  highlight_stars
    @round_score = round_score
  end

  def render?
    score.present?
  end

  private

  def highlight_stars?
    @highlight_stars
  end

  def round_score? 
    @round_score
  end

  def star_classes
    [
      "stars",
      ("stars--highlight" if highlight_stars?)
    ]
  end

  def score
    return "#{@score.round} out of 5" if round_score?

    "#{@score.round(2)} out of 5"
  end
end
