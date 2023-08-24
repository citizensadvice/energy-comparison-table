# frozen_string_literal: true

module NavigationLinksHelper
  def navigation_links
    if scotland?
      scotland_navigation_links
    else
      default_navigation_links
    end
  end

  def default_navigation_links
    [
      {
        url: 'https://www.citizensadvice.org.uk/benefits/',
        title: 'Benefits'
      },
      {
        url: 'https://www.citizensadvice.org.uk/work/',
        title: 'Work'
      },
      {
        url: 'https://www.citizensadvice.org.uk/debt-and-money/',
        title: 'Debt and money'
      },
      {
        url: 'https://www.citizensadvice.org.uk/consumer/',
        title: 'Consumer'
      },
      {
        url: 'https://www.citizensadvice.org.uk/housing/',
        title: 'Housing'
      },
      {
        url: 'https://www.citizensadvice.org.uk/family/',
        title: 'Family'
      },
      {
        url: 'https://www.citizensadvice.org.uk/law-and-courts/',
        title: 'Law and courts'
      },
      {
        url: 'https://www.citizensadvice.org.uk/immigration/',
        title: 'Immigration'
      },
      {
        url: 'https://www.citizensadvice.org.uk/health/',
        title: 'Health'
      },
      {
        url: 'https://www.citizensadvice.org.uk/about-us',
        title: 'More from us'
      }
    ]
  end

  def scotland_navigation_links
    [
      {
        url: 'https://www.citizensadvice.org.uk/scotland/benefits/',
        title: 'Benefits'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/work/',
        title: 'Work'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/debt-and-money/',
        title: 'Debt and money'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/consumer/',
        title: 'Consumer'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/housing/',
        title: 'Housing'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/family/',
        title: 'Family'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/law-and-courts/',
        title: 'Law and courts'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/immigration/',
        title: 'Immigration'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/health/',
        title: 'Health'
      },
      {
        url: 'https://www.citizensadvice.org.uk/scotland/about-us',
        title: 'More help'
      }
    ]
  end
end