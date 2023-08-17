# frozen_string_literal: true

module ApplicationHelper
  def scotland?
    request.path.starts_with?("/scotland")
  end

  def wales?
    request.path.starts_with?("/wales")
  end
end
