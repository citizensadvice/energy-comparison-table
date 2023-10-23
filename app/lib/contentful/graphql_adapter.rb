# frozen_string_literal: true

module Contentful
  # https://github.com/github/graphql-client/blob/master/guides/remote-queries.md
  class GraphqlAdapter
    def execute(document:, operation_name:, variables: {}, context: {})
      @connection ||= connection

      tagged_variables = add_tags_to_variables(variables)
      ranked_variables = add_top_three_ranks_to_variables(tagged_variables)

      response = @connection.post(api_url, {
        query: document.to_query_string,
        operationName: operation_name,
        variables: ranked_variables,
        context:
      }) do |req|
        req.headers["Authorization"] = "Bearer #{access_token}"
      end

      raise QueryError, response.errors[:data].join(", ") if errors_present?(response)

      response.body
    end

    def connection
      Faraday.new do |conn|
        # Using net_http_persistent for persistent connections significantly
        # improves cache-hits when querying the Contentful GraphQL API.
        conn.adapter :net_http_persistent
        conn.use Faraday::Response::RaiseError
        conn.request :json
        conn.response :json
      end
    end

    protected

    def space_id
      ENV.fetch("CONTENTFUL_SPACE_ID")
    end

    def environment_id
      ENV.fetch("CONTENTFUL_ENVIRONMENT_ID")
    end

    def api_url
      "https://graphql.contentful.com/content/v1/spaces/#{space_id}/environments/#{environment_id}"
    end

    def access_token
      ENV.fetch("CONTENTFUL_CDA_TOKEN")
    end

    def add_tags_to_variables(variables)
      if Feature.enabled? "USE_TEST_SUPPLIERS"
        variables.merge({ tag_filter: { id_contains_some: "test" } })
      else
        variables.merge({ tag_filter: { id_contains_none: "test" } })
      end
    end

    def add_top_three_ranks_to_variables(variables)
      if Feature.enabled? "USE_TEST_SUPPLIERS"
        variables.merge({ top_three_ranks: [901, 902, 903] })
      else
        variables.merge({ top_three_ranks: [1, 2, 3] })
      end
    end

    def errors_present?(response)
      response.respond_to?(:errors) && response.errors[:data].present?
    end
  end
end
