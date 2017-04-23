require "spec_helper"

RSpec.describe Zget::Zget do
  describe "#initialize" do
    context "with no options" do
      subject { described_class.new }

      it { is_expected.to be_a described_class }
      it { expect(subject.file_or_alias).to be_nil }
      it { expect(subject.output).to be_nil }
    end

    context "with options" do
      let(:options) { { file_or_alias: "README.md" } }

      subject { described_class.new options }

      it { is_expected.to be_a described_class  }
      it { expect(subject.file_or_alias).to eq "README.md" }
      it { expect(subject.output).to be_nil }
    end
  end

  describe "#call" do
    pending
  end
end

