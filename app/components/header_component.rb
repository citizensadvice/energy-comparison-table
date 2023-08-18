# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  delegate :scotland?, to: :helpers

  def call
    render CitizensAdviceComponents::Header.new do |c|
      c.with_logo(**logo)
      c.with_search_form(search_action_url: search_url)
    end
  end

  def logo
    {
      url: logo_url,
      title: "Citizens Advice Homepage"
    }
  end

  def logo_url
    if scotland?
      "https://www.citizensadvice.org.uk/scotland"
    else
      "https://www.citizensadvice.org.uk"
    end
  end

  def search_url
    if scotland?
      "https://www.citizensadvice.org.uk/scotland/resources-and-tools/search-navigation-tools/Search/"
    else
      "https://www.citizensadvice.org.uk/s"
    end
  end
end
