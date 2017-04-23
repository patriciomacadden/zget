require "spec_helper"

RSpec.describe Zget::Zput do
  describe "#initialize" do
    context "with no options" do
      it { expect { described_class.new }.to raise_error ArgumentError }
    end

    context "with options" do
      let(:_alias) { "asdf" }
      let(:bind_address) { "192.168.0.10" }
      let(:file) { File.join File.dirname(__FILE__), "..", "..", "fixtures", "file.txt" }
      let(:options) { { _alias: _alias, bind_address: bind_address, file: file, port: port } }
      let(:port) { 7777 }

      subject { described_class.new options }

      context "invalid bind address" do
        let(:bind_address) { "invalid" }

        it { expect { subject }.to raise_error IPAddr::InvalidAddressError }
      end

      context "invalid file" do
        let(:file) { "invalid" }

        it { expect { subject }.to raise_error Zget::InvalidFileError }
      end

      context "invalid port" do
        let(:port) { 909090 }

        it { expect { subject }.to raise_error Zget::InvalidPortError }
      end

      context "minimal options" do
        let(:options) { { file: file } }

        it { is_expected.to be_a described_class }

        it "alias is not nil" do
          expect(subject.alias).not_to be_nil
        end

        it "bind address defaults to 0.0.0.0" do
          expect(subject.bind_address.to_s).to eq "0.0.0.0"
        end

        it "port defaults to 6666" do
          expect(subject.port).to eq 6666
        end
      end

      it { is_expected.to be_a described_class }

      it "sets the alias" do
        expect(subject.alias).to eq "asdf"
      end

      it "sets the bind address" do
        expect(subject.bind_address).to eq "192.168.0.10"
      end

      it "sets the file" do
        expect(subject.file).to eq File.join(File.dirname(__FILE__), "..", "..", "fixtures", "file.txt")
      end

      it "sets the port" do
        expect(subject.port).to eq 7777
      end
    end
  end

  describe "#call" do
    pending
  end
end

