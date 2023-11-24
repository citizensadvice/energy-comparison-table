# frozen_string_literal: true

module DataLayer
  extend ActiveSupport::Concern

  included do
    def data_layer_properties
      {
        platform: "content-platform",
        siteType: "Public Website",
        pageTemplate: "Customer Service Ratings Page",
        pageType: "Customer Service Ratings Page",
        # language confusingly represents the current country: England, Wales etc.
        # but needs to have this name to match up with Episerver page data.
        language: helpers.current_country.to_s.capitalize
      }
    end
    helper_method :data_layer_properties
  end
end
