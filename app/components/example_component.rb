# frozen_string_literal: true

class ExampleComponent < ViewComponent::Base
  attr_reader :title

  def initialize(title:)
    super
    @title = title
  end
end
