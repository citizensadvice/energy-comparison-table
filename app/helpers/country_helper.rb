# frozen_string_literal: true

module CountryHelper
  def current_country
    request.params[:country]&.downcase
  end
end
