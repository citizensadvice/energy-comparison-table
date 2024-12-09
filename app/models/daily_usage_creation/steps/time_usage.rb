# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class TimeUsage < WizardSteps::Step
      attribute :hours, :integer
      attribute :minutes, :integer

      def skipped?
        @store[:cyclical?]
      end
    end
  end
end
