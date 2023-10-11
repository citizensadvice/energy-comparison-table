# frozen_string_literal: true

module Contentful
  module Graphql
    HTTP = Contentful::GraphqlAdapter.new
    SCHEMA = if Feature.enabled? "LOAD_SCHEMA_DYNAMICALLY"
               GraphQL::Client.load_schema(http)
             else
               GraphQL::Client.load_schema("db/schema.json")
             end

    Client = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
  end
end
