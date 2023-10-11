# frozen_string_literal: true

module ApplicationHelper
  def logo_url
    if scotland?
      "https://www.citizensadvice.org.uk/scotland"
    else
      "https://www.citizensadvice.org.uk"
    end
  end

  def scotland?
    request.path.starts_with?("/scotland")
  end

  def wales?
    request.path.starts_with?("/wales")
  end
end
