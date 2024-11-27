# frozen_string_literal: true

class Appliance
  include ActiveModel::Model

  attr_accessor :data

  delegate :name, :category, :wattage, :usage_type, :additional_usage, to: :data

  def self.fetch_all
    response = Contentful::Graphql::Client.query(Queries::Appliances)

    response.data.appliance_collection.items.map do |item|
      Appliance.new(data: item)
    end
  end

  def id
    data.sys.id
  end

  def cyclical?
    usage_type == "Cycles"
  end
end
