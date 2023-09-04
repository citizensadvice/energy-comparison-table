# frozen_string_literal: true

class SuppliersController < ApplicationController
  include SwiftypeMeta

  before_action :set_supplier, only: :show
  before_action :set_suppliers, only: :index
  before_action :set_page_meta_tags, :set_swiftype_meta_tags

  attr_accessor :supplier

  helper_method :supplier

  def index
    ranked_suppliers = @suppliers.select(&:ranked?)
    unranked_suppliers = @suppliers.reject(&:ranked?)

    render "index", locals: { ranked_suppliers:, unranked_suppliers:, current_country: }
  end

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

  def set_suppliers
    @suppliers = Supplier.fetch_all
  end

  def set_swiftype_meta_tags
    add_swiftype_meta([
      { name: "search_type_filter", content: "everything", type: "string" },
      { name: "search_type_filter", content: "advice", type: "string" },
      { name: "audience_filter", content: current_country, type: "string" }
    ])
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

  def current_country
    request.params[:country]&.downcase || "england"
  end
end
