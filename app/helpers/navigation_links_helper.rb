# frozen_string_literal: true

module NavigationLinksHelper
  def navigation_links
    return country_navigation_links if current_country.blank?

    country_navigation_links(country: "/#{current_country}")
  end

  def country_navigation_links(country: nil)
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
      },
      {
        url: "#{country}/about-us/",
        title: "More from us"
      }
    ]
  end
end
