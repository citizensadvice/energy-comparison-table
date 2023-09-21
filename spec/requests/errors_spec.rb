# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Errors" do
  describe "handling 404s" do
    it "renders the 404 error page" do
      get '/nonsense-url'
      expect(response).to render_template("errors/404")
      expect(response).to have_http_status(:not_found)
    end
  end
end
