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

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "suppliers#index"

  constraints CountryConstraint.new do
    scope "(:country)" do
      resources :suppliers, only: %i[index show]
    end
  end

  match "*path", to: "application#not_found", via: :all
end
