# frozen_string_literal: true

module Contentful
  module Graphql
    class Client
      attr_reader :http, :schema, :client

      delegate :parse, :query, to: :client

      def initialize
        @http = Contentful::Graphql::Adapter.new
        @schema = load_schema
        @client = GraphQL::Client.new(schema:, execute: http)
      end

      private

      def load_schema
        if Feature.enabled? "LOAD_SCHEMA_DYNAMICALLY"
          GraphQL::Client.load_schema(http)
        else
          GraphQL::Client.load_schema("db/schema.json")
        end
      end
    end
  end
end
