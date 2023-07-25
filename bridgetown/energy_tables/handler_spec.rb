require 'rspec'
require_relative './handler.rb'

RSpec.describe EnergyTableComparison::SiteGenerator do 
  it "works" do
    described_class.generate
  end
end

RSpec.describe "handler" do
  it "works" do
    handler(event: {}, context: {})
  end
end