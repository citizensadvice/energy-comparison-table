# frozen_string_literal: true

# Share a service name in order to group all integrations
service_name = "energy-csr-table"
ci_test = ENV.fetch("CI_TEST", false)
SemanticLogger.application = service_name

# Disable datadog if stdout is a TTY because it probably means a user is running
# Rails in a terminal
unless $stdout.tty? || ci_test
  Datadog.configure do |c|
    c.service = service_name
    c.tracing.instrument :rails
    c.tracing.instrument :faraday, describes: /graphql\.contentful\.com/, service_name: "#{service_name}-contentful-graphql"
  end
end
