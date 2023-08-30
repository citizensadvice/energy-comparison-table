# frozen_string_literal: true

class FooterComponent < ViewComponent::Base
  def initialize(current_path:, feedback_survey_id:, columns:, feedback_title: nil, legal_summary: nil)
    super
    @current_path = current_path
    @feedback_survey_id = feedback_survey_id
    @feedback_title = feedback_title
    @columns = columns
    @legal_summary = legal_summary
  end

  def call
    render CitizensAdviceComponents::Footer.new do |c|
      c.with_feedback_link(url: research_uri.to_s,
                           title: @feedback_title,
                           external: true,
                           new_tab: true)
      c.with_columns(@columns)
      c.with_legal_summary(@legal_summary)
    end
  end

  private

  def research_uri
    hash = { p: @current_path }

    URI::HTTPS.build(host: "www.research.net", path: "/r/#{@feedback_survey_id}", query: hash.to_query)
  end
end
