# frozen_string_literal: true

module Input
  class SelectComponentPreview < ViewComponent::Preview
    def default
      component = Input::SelectComponent.new(select_options: options, name: "product", label: "Choose a product", type: :text)
      render component
    end

    def with_error
      component = Input::SelectComponent.new(select_options: options, name: "product", label: "Choose a product", type: :text,
                                             options: { error_message: "Select a product" })
      render component
    end

    def with_hint
      component = Input::SelectComponent.new(select_options: options, name: "product", label: "Choose a product", type: :text,
                                             options: { hint: "Choose a product from the list below" })
      render component
    end

    def with_value
      component = Input::SelectComponent.new(select_options: options, name: "product", label: "Choose a product", type: :text,
                                             options: { value: "FYLCA", hint: "Choose a product from the list below" })
      render component
    end

    private

    def options
      [
        ["Casebook", "casebook"],
        ["Content platform", "content-platform"],
        ["SMT", "smart-meter-tool"],
        ["Find your local Citizens Advice", "FYLCA"]
      ]
    end
  end
end
