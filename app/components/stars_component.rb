# frozen_string_literal: true

class StarsComponent < ViewComponent::Base
  def initialize(stars:, highlight_stars: false)
    @stars = stars
    @highlight_stars = highlight_stars
  end

  def star_classes
    [
      "stars",
      ("stars--highlight" if @highlight_stars)
    ]
  end

  def render_star(star)
    case star
    when :full
      render Star::FullComponent.new
    when :half
      render Star::HalfComponent.new
    else
      render Star::EmptyComponent.new
    end
  end
end
