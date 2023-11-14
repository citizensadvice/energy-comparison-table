# frozen_string_literal: true

Around do |scenario, block|
  ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
    block.call
  end
end
