# frozen_string_literal: true

class ExampleComponentPreview < ViewComponent::Preview
  def default
    render(ExampleComponent.new(title: "My great title"))
  end
end
