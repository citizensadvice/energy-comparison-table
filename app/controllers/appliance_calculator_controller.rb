# frozen_string_literal: true

class ApplianceCalculatorController < ApplicationController
  layout "appliance_calculator"

  after_action :set_headers

  def index; end

  private

  def set_headers
    response.headers["cache-control"] = "no-store"
  end
end
