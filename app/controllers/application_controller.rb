# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SwiftypeMeta

  layout :layout_type

  def not_found
    render "errors/not_found", status: :not_found, format: :html
  end

  private

  def layout_type
    request.path.starts_with?("/scotland") ? "energy_comparison_table_scotland" : "application"
  end
end
