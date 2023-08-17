# frozen_string_literal: true

require "rails_helper"

RSpec.describe Feature do
  describe ".enabled?" do
    it "is true for 'true'" do
      ClimateControl.modify({ FF_EXAMPLE: "true" }) do
        expect(described_class).to be_enabled("FF_EXAMPLE")
      end
    end

    it "is true for '1'" do
      ClimateControl.modify({ FF_EXAMPLE: "1" }) do
        expect(described_class).to be_enabled("FF_EXAMPLE")
      end
    end

    it "is true for 'some arbitrary string'" do
      ClimateControl.modify({ FF_EXAMPLE: "some arbitrary string" }) do
        expect(described_class).to be_enabled("FF_EXAMPLE")
      end
    end

    it "is false for 'false'" do
      ClimateControl.modify({ FF_EXAMPLE: "false" }) do
        expect(described_class).not_to be_enabled("FF_EXAMPLE")
      end
    end

    it "is false for '0'" do
      ClimateControl.modify({ FF_EXAMPLE: "0" }) do
        expect(described_class).not_to be_enabled("FF_EXAMPLE")
      end
    end

    it "is false for ''" do
      ClimateControl.modify({ FF_EXAMPLE: "" }) do
        expect(described_class).not_to be_enabled("FF_EXAMPLE")
      end
    end

    it "is false for completely absent" do
      expect(described_class).not_to be_enabled("FF_EXAMPLE")
    end
  end
end
