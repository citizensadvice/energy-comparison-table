# frozen_string_literal: true

module FooterHelper
  def public_website_footer_nav_links
    host_path = "https://www.citizensadvice.org.uk"

    [
      {
        title: "Advice",
        links: format_links(navigation_links).map(&:symbolize_keys)
      },
      {
        title: "Resources and tools",
        links: [
          { title: "Adviser resources", url: "#{host_path}/about-us/adviser-resources/" },
          { title: "Education resources", url: "#{host_path}/about-us/how-we-provide-advice/our-prevention-work/education/" },
          { title: "Site search", url: "#{host_path}/s" },
          { title: "A to Z of advice", url: "#{host_path}/resources-and-tools/search-navigation-tools/a-to-z-of-advice/" }
        ]
      },
      {
        title: "More from us",
        links: [
          { title: "About us", url: "#{host_path}/about-us/" },
          { title: "Contact us", url: "#{host_path}/about-us/contact-us/contact-us/contact-us/" },
          { title: "Support us", url: "#{host_path}/about-us/support-us/" },
          { title: "Annual reports", url: "#{host_path}/about-us/our-work/annual-reports/" },
          { title: "Complaints", url: "#{host_path}/about-us/contact-us/contact-us/make-a-complaint-about-us/" },
          { title: "Media", url: "#{host_path}/about-us/about-us1/media/" },
          { title: "Modern slavery statement", url: "#{host_path}/about-us/modern-slavery-statement/" },
          { title: "Policy research", url: "#{host_path}/about-us/policy/" },
          { title: "Volunteering", url: "#{host_path}/about-us/support-us/volunteering/" },
          { title: "Jobs", url: "#{host_path}/about-us/job-and-voluntary-opportunities/" }
        ]
      },
      {
        title: "About this site",
        links: [
          { title: "Accessibility statement", url: "#{host_path}/resources-and-tools/about-this-site/accessibility/" },
          { title: "Terms and conditions", url: "#{host_path}/resources-and-tools/about-this-site/terms-and-conditions/" },
          { title: "Privacy and cookies", url: "#{host_path}/about-us/citizens-advice-privacy-policy/" }
        ]
      }
    ]
  end

  def scotland_public_website_footer_nav_links
    host_path = "https://www.citizensadvice.org.uk/scotland"

    [
      {
        title: "Advice",
        links: format_links(navigation_links).map(&:symbolize_keys)
      },
      {
        title: "Resources and tools",
        links: [
          { title: "Where to get advice", url: "#{host_path}/about-us/get-advice-s/" },
          { title: "Template letters", url: "#{host_path}/consumer/template-letters/letters/" },
          { title: "A to Z of advice", url: "#{host_path}/resources-and-tools/search-navigation-tools/a-to-z-of-advice/" }
        ]
      },
      {
        title: "More from us",
        links: [
          { title: "More help", url: "#{host_path}/about-us/" },
          { title: "Complaints", url: "https://www.cas.org.uk/complaints" },
          { title: "Campaigns", url: "https://www.cas.org.uk/campaigns" },
          { title: "Publications", url: "https://www.cas.org.uk/publications" },
          { title: "Support us", url: "https://www.cas.org.uk/about-us/support-our-work" },
          { title: "Volunteering", url: "https://www.cas.org.uk/about-us/volunteer-citizens-advice-bureau" }
        ]
      },
      {
        title: "About this site",
        links: [
          { title: "Disclaimer and copyright", url: "#{host_path}/resources-and-tools/about-this-site/terms-and-conditions/" }
        ]
      }
    ]
  end

  def format_links(links)
    return links if current_request_country == "england"

    links.each { |link| link["url"]&.prepend("/#{current_request_country}") }
  end

  def current_request_country
    request.params[:country].presence || "england"
  end
end
