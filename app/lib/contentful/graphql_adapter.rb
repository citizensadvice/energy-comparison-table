# frozen_string_literal: true

module Contentful
  # https://github.com/github/graphql-client/blob/master/guides/remote-queries.md
  class GraphqlAdapter
    def execute(document:, operation_name:, variables: {}, context: {})
      @connection ||= connection
      response = @connection.post(api_url, {
        query: document.to_query_string,
        operationName: operation_name,
        variables:,
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
  end
end
