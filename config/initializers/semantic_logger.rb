# frozen_string_literal: true

Rails.application.configure do
  config.after_initialize do
    config.rails_semantic_logger.semantic     = true
    config.rails_semantic_logger.started      = false
    config.rails_semantic_logger.processing   = false
    config.rails_semantic_logger.rendered     = false

    # If stdout is a terminal, we want the fancy output. If not, it's
    # Docker or production and might be linked to Datadog
    config.colorize_logging = $stdout.tty?
    config.rails_semantic_logger.format = $stdout.tty? ? :color : :json

    # Always log to stdout
    unless Rails.env.test?
      config.rails_semantic_logger.add_file_appender = false
      config.semantic_logger.add_appender(
        io: $stdout,
        level: config.log_level,
        formatter: config.rails_semantic_logger.format
      )
    end
  end
end
