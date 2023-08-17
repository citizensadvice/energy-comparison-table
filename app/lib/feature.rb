# frozen_string_literal: true

require "active_model/type"

# Tiny class for checking if a feature is enabled
class Feature
  def self.enabled?(flag_name)
    # Use ActiveModel's boolean type which recognises the strings 'false'/'0'/'' as false values
    ActiveModel::Type::Boolean.new.cast(ENV.fetch(flag_name, nil))
  end
end
