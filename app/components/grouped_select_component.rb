# frozen_string_literal: true

class GroupedSelectComponent < CitizensAdviceComponents::Select
  def call
    render CitizensAdviceComponents::Input.new(**base_input_args) do
      tag.select(class: select_classes, **input_attributes) do
        grouped_options_for_select(select_options, value)
      end
    end
  end
end
