# frozen_string_literal: true

module NavigationLinksHelper
  def navigation_links
    return country_advice_links << more_from_us_link if current_country.blank?

    country_advice_links(country: "/#{current_country}") << more_from_us_link(country: "/#{current_country}")
  end

  def more_from_us_link(country: nil)
    {
      url: "#{country}/about-us/",
      title: "More from us"
    }
  end
  def country_advice_links(country: nil)
    [
      {
        url: "#{country}/benefits/",
        title: "Benefits"
      },
      {
        url: "#{country}/work/",
        title: "Work"
      },
      {
        url: "#{country}/debt-and-money/",
        title: "Debt and money"
      },
      {
        url: "#{country}/consumer/",
        title: "Consumer"
      },
      {
        url: "#{country}/housing/",
        title: "Housing"
      },
      {
        url: "#{country}/family/",
        title: "Family"
      },
      {
        url: "#{country}/law-and-courts/",
        title: "Law and courts"
      },
      {
        url: "#{country}/immigration/",
        title: "Immigration"
      },
      {
        url: "#{country}/health/",
        title: "Health"
      }
    ]
  end
end
