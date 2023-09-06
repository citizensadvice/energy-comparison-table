# frozen_string_literal: true

module Contentful
  module Graphql
    def query(definition, variables: {}, context: {})
      variables.merge!({ tag_filter: })

      response = client.query(definition, variables:, context:)

      raise QueryError, response.errors[:data].join(", ") if response.errors[:data].present?

      response.data
    end

    # We use tag filters to fetch test or production data
    def tag_filter
      if Feature.enabled? "USE_TEST_SUPPLIERS"
        { id_contains_some: "test" }
      else
        { id_contains_none: "test" }
      end
    end

    HTTP = Contentful::GraphqlAdapter.new
    SCHEMA = if Feature.enabled? "LOAD_SCHEMA_DYNAMICALLY"
               GraphQL::Client.load_schema(http)
             else
               GraphQL::Client.load_schema("db/schema.json")
             end

    Client = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
  end
end
