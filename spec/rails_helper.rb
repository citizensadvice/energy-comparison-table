# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
# Add additional requires below this line. Rails is not loaded until this point!
require "view_component/test_helpers"

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Remove this line to enable support for ActiveRecord
  config.use_active_record = false
  config.include ViewComponent::TestHelpers, type: :component

  # If you enable ActiveRecord support you should uncomment these lines,
  # note if you'd prefer not to run each example within a transaction, you
  # should set use_transactional_fixtures to false.
  #
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Add dummy env vars for tests so rspec can run without env vars
  # If you are re-recording VCR cassettes you will need to have the correct
  # vars in your .env
  config.around do |example|
    ClimateControl.modify({
      CONTENTFUL_CDA_TOKEN: ENV.fetch("CONTENTFUL_CDA_TOKEN", "contentful-cda-token"),
      CONTENTFUL_ENVIRONMENT_ID: ENV.fetch("CONTENTFUL_ENVIRONMENT_ID", "contentful-env-id"),
      CONTENTFUL_SPACE_ID: ENV.fetch("CONTENTFUL_SPACE_ID", "contentful-space-id"),
      LOAD_SCHEMA_DYNAMICALLY: ENV.fetch("LOAD_SCHEMA_DYNAMICALLY", "false"),
      USE_TEST_SUPPLIERS: ENV.fetch("USE_TEST_SUPPLIERS", "true")
    }) do
      example.run
    end
  end
end
