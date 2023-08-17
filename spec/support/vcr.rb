# frozen_string_literal: true

VCR.configure do |c|
  # This is the directory where VCR will store its "cassettes", i.e. its
  # recorded HTTP interactions.
  c.cassette_library_dir = "spec/cassettes"

  # This line makes it so VCR and WebMock know how to talk to each other.
  c.hook_into :webmock

  # This line makes VCR ignore requests to localhost. This is necessary
  # even if WebMock's allow_localhost is set to true.
  c.ignore_localhost = true

  c.filter_sensitive_data("<CONTENTFUL_CDA_TOKEN>") { ENV.fetch("CONTENTFUL_CDA_TOKEN") }
  c.filter_sensitive_data("<CONTENTFUL_SPACE_ID>") { ENV.fetch("CONTENTFUL_SPACE_ID") }

  c.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
end
