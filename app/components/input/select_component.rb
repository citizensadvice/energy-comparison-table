# frozen_string_literal: true

module Input
  class SelectComponent < CitizensAdviceComponents::Input
    attr_reader :base_input_args, :select_options, :value

    def initialize(select_options:, **args)
      @select_options = select_options
      @base_input_args = args
      super(**@base_input_args)
    end

    private

    def select_classes
      %w[
        select
        cads-input
      ]
    end

    def base_input_attributes
      # selects do not control their current value with the `value` attribute
      super.reject { |k| k == :value }
    end
  end
end
