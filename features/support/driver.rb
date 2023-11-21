# frozen_string_literal: true

class Driver
  include Helpers::EnvVariables

  def initialize
    setup_capybara
  end

  def register
    Capybara.register_driver :headless_chrome do |app|
      Capybara::Selenium::Driver.new(app,
                                     browser: :chrome,
                                     options: chrome_options)
    end
  end

  private

  def setup_capybara
    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :selenium_chrome
      config.app_host = base_url
    end
  end

  def chrome_options
    opts = Selenium::WebDriver::Chrome::Options.new
    opts.add_argument("--no-sandbox")
    opts.add_argument("--headless") unless ci?
    opts.add_argument("--disable-gpu")
    opts.add_argument("--disable-dev-shm-usage")
    opts.add_argument("--remote-debugging-port=9222")
    opts.binary("/usr/bin/google-chrome")
    opts
  end
end
