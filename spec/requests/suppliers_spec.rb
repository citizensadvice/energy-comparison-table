# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Suppliers" do
  context "when no country is specified" do
    it "responds successfully to the suppliers route" do
      get "/suppliers"

      expect(response).to have_http_status :successful
    end

    it "responds successfully to the supplier detail route" do
      get "/suppliers/an-energy-supplier"

      expect(response).to have_http_status :successful
    end
  end

  context "when the country is Scotland" do
    it "responds successfully to the suppliers route" do
      get "/scotland/suppliers"

      expect(response).to have_http_status :successful
    end

    it "responds successfully to the supplier detail route" do
      get "/scotland/suppliers/an-energy-supplier"

      expect(response).to have_http_status :successful
    end
  end

  context "when the country is Wales" do
    it "responds successfully to the suppliers route" do
      get "/wales/suppliers"

      expect(response).to have_http_status :successful
    end

    it "responds successfully to the supplier detail route" do
      get "/wales/suppliers/an-energy-supplier"

      expect(response).to have_http_status :successful
    end
  end

  context "when an invalid country is requested" do
    it "responds successfully to the suppliers route" do
      get "/france/suppliers"

      expect(response).to have_http_status :not_found
    end

    it "responds successfully to the supplier detail route" do
      get "/france/suppliers/an-energy-supplier"

      expect(response).to have_http_status :not_found
    end
  end
end
