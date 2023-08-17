# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SwiftypeMeta

  helper_method :homepage_url

  def not_found
    render "errors/not_found", status: :not_found, format: :html
  end

  def homepage_url
    if request.params[:country].present?
      extent_root_path(country: request.params[:country])
    else
      root_path
    end
  end
end
