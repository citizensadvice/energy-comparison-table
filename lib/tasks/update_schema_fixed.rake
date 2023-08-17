# frozen_string_literal: true

desc "Dump Contentful GraphQL schema for the energy comparison table"
task update_schema_fixed: :environment do
  environment_id = ENV.fetch("CONTENTFUL_ENVIRONMENT_ID")

  raise "update_schema must be run against the master environment" unless environment_id == "master"

  # into the void
  Contentful::Graphql::Client

  result = GraphQL::Client.dump_schema(Contentful::Graphql::HTTP)
  Rails.root.join("db/schema.json").write(result.to_json)
end