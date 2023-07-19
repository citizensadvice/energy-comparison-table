module Builders
  class SuppliersBuilder < SiteBuilder
    def build
      hook :site, :post_read do
        site.data.supplier_data.each do |supplier|
          slug = supplier.supplierName.parameterize
          add_resource :suppliers, "#{slug}.md" do
            name supplier.supplierName
            rank supplier.supplierRank
            billing_information supplier.billing_information
            slug slug
            content "<p>I am the content</p>"
          end
        end
      end
    end
  end
end