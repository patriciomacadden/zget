require "spec_helper"

RSpec.describe Zget::Command do
  describe "#call" do
    subject { described_class.new }

    it "isn't implemented - not supposed to be called" do
      expect { subject.call }.to raise_error NotImplementedError
    end
  end
end

