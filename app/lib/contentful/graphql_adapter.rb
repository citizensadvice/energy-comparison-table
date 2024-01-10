# frozen_string_literal: true

module Contentful
  # https://github.com/github/graphql-client/blob/master/guides/remote-queries.md
  class GraphqlAdapter
    def execute(document:, operation_name:, variables: {}, context: {})
      @connection ||= connection

      ranked_variables = add_ranks_and_tags_to_variables(variables)

      response = @connection.post(api_url, {
        query: document.to_query_string,
        operationName: operation_name,
        variables: ranked_variables,
        context:
      }) do |req|
        req.headers["Authorization"] = "Bearer #{access_token}"
      end

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

    def add_ranks_and_tags_to_variables(variables)
      if Feature.enabled? "USE_TEST_SUPPLIERS"
        variables.merge({ top_three_ranks: [901, 902, 903], tag_filter: { id_contains_some: "test" } })
      else
        variables.merge({ top_three_ranks: [1, 2, 3], tag_filter: { id_contains_none: "test" } })
      end
    end
  end
end
