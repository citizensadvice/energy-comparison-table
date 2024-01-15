# frozen_string_literal: true

class SuppliersController < ApplicationController
  include SwiftypeMeta
  rescue_from StandardError, with: :internal_server_error

  before_action :set_supplier, only: :show
  before_action :set_suppliers, :set_unranked_supplier, only: :index
  before_action :set_page_meta_tags, :set_swiftype_meta_tags
  after_action :cache_control_header

  attr_accessor :supplier, :unranked_supplier

  helper_method :supplier, :ranked_suppliers, :unranked_suppliers, :unranked_supplier, :supplier_with_top_three

  def index; end

  def show; end

  private

  def permitted_params
    params.permit(:id)
  end

  # sets the supplier used in the supplier detail page
  def set_supplier
    @supplier = supplier_with_top_three.find { |s| s.slug == permitted_params[:id] }
  end

  # sets all supplier array used in the main suppliers table page
  def set_suppliers
    @suppliers = Supplier.fetch_all
  end

  def ranked_suppliers
    @suppliers.select(&:data_available)
  end

  def unranked_suppliers
    @suppliers.reject(&:data_available)
  end

  def set_unranked_supplier
    @unranked_supplier = unranked_suppliers.find { |s| s.slug == permitted_params[:id] }
  end

  def supplier_with_top_three
    @supplier_with_top_three ||= Supplier.fetch_with_top_three(permitted_params[:id])
  end

  def set_swiftype_meta_tags
    add_swiftype_meta([
      { name: "search_type_filter", content: "everything", type: "string" },
      { name: "search_type_filter", content: "advice", type: "string" },
      { name: "audience_filter", content: helpers.current_country || "england", type: "string" }
    ])
  end

  def set_page_meta_tags
    # meta tags are set by the meta-tags gem.  See https://github.com/kpumuk/meta-tags
    # Use existing Episerver path for favicon and touch icon

    set_meta_tags(
      title: meta_title,
      icon: [
        { href: "/static/layout/favicon.ico" },
        { href: "/static/images/apple-touch-icon.png", rel: "apple-touch-icon", type: "image/png" }
      ]
    )
  end

  def meta_title
    return "Compare energy suppliers' customer service" if supplier.blank?

    "#{supplier.name} customer service performance"
  end

  def custom_data_layer_properties
    if supplier.blank?
      {
        pageTemplate: "Energy Customer Service Ratings Table",
        pageType: "Energy Customer Service Ratings Table"
      }
    else
      {
        pageTemplate: "Energy Customer Service Ratings - #{supplier.name}",
        pageType: "Energy Customer Service Ratings - #{supplier.name}"
      }
    end
  end

  def cache_control_header
    expires_in(
      5.minutes,
      public: true,
      "s-maxage": 5.minutes,
      must_revalidate: true
    )
  end
end
