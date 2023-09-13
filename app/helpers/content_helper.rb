# frozen_string_literal: true

module ContentHelper
  def on_this_page_links(supplier_name)
    [
      {
        id: scores_fragment,
        label: "#{supplier_name} score for April to June 2023"
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
end
