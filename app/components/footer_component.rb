# frozen_string_literal: true

class FooterComponent < ViewComponent::Base
  delegate :scotland?, :scotland_public_website_footer_nav_links, :public_website_footer_nav_links, to: :helpers

  def initialize(current_path:)
    super
    @current_path = current_path
  end

  def call
    render CitizensAdviceComponents::Footer.new do |c|
      c.with_feedback_link(url: research_uri.to_s,
                           title: feedback_title,
                           external: true,
                           new_tab: true)
      c.with_columns(columns)
      c.with_legal_summary(@legal_summary)
    end
  end

  private

  def columns
    scotland? ? scotland_public_website_footer_nav_links : public_website_footer_nav_links
  end

  def feedback_survey_id
    scotland? ? "SCX56FR" : "J8PLH2H"
  end

  def feedback_title
    "Your feedback helps us make our digital services better. Give us feedback" if scotland?
  end

  def research_uri
    hash = { p: @current_path }

    URI::HTTPS.build(host: "www.research.net", path: "/r/#{feedback_survey_id}", query: hash.to_query)
  end
end
