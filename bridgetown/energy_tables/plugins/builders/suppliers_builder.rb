module Builders
  class SuppliersBuilder < SiteBuilder
    def build
      hook :site, :post_read do
        site.data.supplier_data.each do |supplier|
          slug = format_slug(supplier.supplierName)

          add_resource :suppliers, "#{slug}.md" do
            layout "supplier"
            id supplier.supplierId
            name supplier.supplierName
            rank supplier.supplierRank
            ranked supplier.dataAvailable.downcase == "true"
            billing_info supplier.billingInformation
            slug from: ->{ format_slug(supplier.supplierName) }
          end
        end 
      end
    end

    private

    def format_slug(supplier_name)
      supplier_name.parameterize
    end
  end
end