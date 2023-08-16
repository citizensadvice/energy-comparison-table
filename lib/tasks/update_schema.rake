# frozen_string_literal: true

desc "Dump Contentful GraphQL schema for the energy comparison table"
task update_schema: :environment do
  environment_id = ENV.fetch("CONTENTFUL_ENVIRONMENT_ID")

  raise "update_schema must be run against the master environment" unless environment_id == "master"

  result = GraphQL::Client.dump_schema(Contentful::Graphql::Client.new.http)
  Rails.root.join("db/schema.json").write(result.to_json)
end
