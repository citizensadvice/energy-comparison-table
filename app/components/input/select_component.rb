# frozen_string_literal: true

module Input
  class SelectComponent < CitizensAdviceComponents::Input
    attr_reader :base_input_args, :select_options

    def initialize(select_options:, **args)
      @select_options = select_options
      @base_input_args = args
      super(**@base_input_args)
    end

    def select_classes
      %w[
        select
        cads-input
      ]
    end
  end
end
