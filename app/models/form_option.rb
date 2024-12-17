# frozen_string_literal: true

class FormOption
  attr_reader :text, :value

  def initialize(text:, value:)
    @text = text
    @value = value
  end
end
