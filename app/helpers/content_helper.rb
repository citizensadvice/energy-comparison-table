# frozen_string_literal: true

module ContentHelper
  def on_this_page_links(supplier_name)
    [
      {
        id: scores_fragment,
        label: "#{supplier_name} score for July to September 2023"
      },
      {
        id: contact_details_fragment,
        label: "Customer services contact details for #{supplier_name}"
      }
    ]
  end

  def scores_fragment
    "scores"
  end

  def contact_details_fragment
    "contactDetails"
  end

  def country_url(path)
    return path if current_country.blank?

    "/#{current_country}#{path}"
  end

  def unranked_supplier_button_classes
    %w[
      cads-button
      cads-button__primary
      gtm-select-unranked-supplier
    ]
  end
end
