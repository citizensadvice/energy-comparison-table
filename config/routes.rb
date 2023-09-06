# frozen_string_literal: true

class CountryConstraint
  def initialize
    @valid_countries = [nil, "wales", "scotland"]
  end

  def matches?(request)
    valid_country?(request) && valid_format?(request)
  end

  def valid_country?(request)
    @valid_countries.include?(request.params[:country])
  end

  def valid_format?(request)
    request.format == :html
  end
end

# Requests to this app are controlled by CloudFront in the public-website-config repo
# The original request is sent to this app by CloudFront, so we need this app to respond to
# the path below.
# If the dummy page entry that represents this app is moved in Contentful, this url will need to be updated,
# a redirect added in Contentful, and the CloudFront config changed to reflect the new url.
CSR_APP_PATH = "/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  constraints CountryConstraint.new do
    scope "(:country)" do
      get CSR_APP_PATH, to: "suppliers#index", as: "suppliers"
      get "#{CSR_APP_PATH}/:id", to: "suppliers#show", as: "supplier"
    end
  end

  get "/status", to: "status#index"

  match "*path", to: "application#not_found", via: :all
end
