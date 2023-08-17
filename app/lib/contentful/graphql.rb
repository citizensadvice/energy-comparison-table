# frozen_string_literal: true

module Contentful
  module Graphql
    class SillyClass < Contentful::GraphqlAdapter
      def hai
        puts "hai"
      end
    end


    HTTP = SillyClass.new
    SCHEMA = GraphQL::Client.load_schema("db/schema.json")
    Client = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
  end
end
