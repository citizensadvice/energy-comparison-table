# frozen_string_literal: true

module Helpers
  module EnvVariables
    def browser
      ENV.fetch("BROWSER", "chrome").to_sym
    end

    def base_url
      ENV.fetch("TESTING_BASE_URL")
    end
  end
end
