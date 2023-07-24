require 'bundler/setup'

module Builders
  class SuppliersBuilder < SiteBuilder
    def build
      hook :site, :post_read do
        site.data.supplier_data.each do |supplier|
          next unless valid_supplier?(supplier)
          
          slug = format_slug(supplier.supplierName)

          add_resource :suppliers, "#{slug}.md" do
            layout "supplier"
            id supplier.supplierId
            name supplier.supplierName
            rank supplier.supplierRank
            billing_info supplier.billingInformation
            slug from: ->{ format_slug(supplier.supplierName) }
            ranked from: ->{ ranked?(supplier) }
            whitelabelled from: ->{ whitelabelled?(supplier) }
            whitelabel_name from: ->{ format_whitelabel_name(supplier) }
          end
        end 
      end
    end

    private

    def format_slug(supplier_name)
      supplier_name.parameterize
    end

    def format_whitelabel_name(supplier)
      whitelabel_supplier = site.data.supplier_data.select do |s| 
        s.SupplierId == supplier.whilteLabelId
      end.first

      return if whitelabel_supplier.nil?

      whitelabel_supplier.supplierName 
    end

    def ranked?(supplier)
      supplier.dataAvailable.downcase == "true"
    end

    def whitelabelled?(supplier)
      supplier.whilteLabelId != "0"
    end

    def valid_supplier?(supplier)
      whitelabelled?(supplier) || ranked?(supplier)
    end
  end
end