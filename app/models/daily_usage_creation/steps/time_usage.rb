# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class TimeUsage < WizardSteps::Step
      attribute :hours, :integer
      attribute :minutes, :integer
      attribute :frequency, :string

      def label
        "On average, how often do you use #{added_applicance_name}(s)?"
      end

      def frequency_options
        [
          FormOption.new(text: "Day", value: :daily),
          FormOption.new(text: "Week", value: :weekly)
        ]
      end

      def skipped?
        @store[:cyclical?]
      end

      def added_applicance_name
        @store[:added_appliance].dig("data", "name") || "appliance"
      end
    end
  end
end
