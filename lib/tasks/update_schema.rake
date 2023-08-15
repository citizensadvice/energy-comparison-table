# frozen_string_literal: true

desc "Dump Contentful GraphQL schema for the energy comparison table"
task update_schema: :environment do
  environment_id = ENV.fetch("CONTENTFUL_ENVIRONMENT_ID")

  # FIX-ME: the client needs to be loaded before the HTTP constant can be accessed
  Contentful::Graphql::Client

  raise "update_schema must be run against the master environment" unless environment_id == "master"

  result = GraphQL::Client.dump_schema(Contentful::Graphql::HTTP)
  Rails.root.join("db/schema.json").write(result.to_json)
end
