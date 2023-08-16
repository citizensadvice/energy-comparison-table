# frozen_string_literal: true

module Contentful
  module Graphql
    HTTP = Contentful::Graphql::Adapter.new
    SCHEMA = GraphQL::Client.load_schema("db/schema.json")
    Client = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
  end
end
