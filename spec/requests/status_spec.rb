# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Statuses" do
  describe "HEAD /index" do
    it "responds successfully to a HEAD request to /status" do
      head "/status"
      expect(response).to have_http_status :ok
    end
  end
end
