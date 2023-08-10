# frozen_string_literal: true

class SuppliersController < ApplicationController
  before_action :set_supplier, only: :show
  before_action :set_page_meta_tags

  attr_accessor :supplier

  helper_method :supplier

  def index; end

  def show; end

  private

  def permitted_params
    params.permit(:id)
  end

  def set_supplier
    @supplier = {
      name: permitted_params[:id]
    }
  end

  def set_page_meta_tags
    # meta tags are set by the meta-tags gem.  See https://github.com/kpumuk/meta-tags
    set_meta_tags(
      title: meta_title
    )
  end

  def meta_title
    return "Compare energy suppliers' customer service" if supplier.blank?

    "#{supplier[:name]} customer service performance"
  end
end