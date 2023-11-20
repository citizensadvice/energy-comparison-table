# frozen_string_literal: true

class Driver
  include Helpers::EnvVariables

  def initialize
    setup_capybara
  end

  def register
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(
        app,
        browser:
      )
    end
  end

  private

  def setup_capybara
    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :selenium
      config.app_host = base_url
    end
  end
end
