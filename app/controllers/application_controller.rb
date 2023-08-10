# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_found
    render "errors/not_found", status: :not_found, format: :html
  end
end
