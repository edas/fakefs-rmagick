require "spec_helper"

RSpec.describe FakeFS::Magick::RealImage do

  let(:local_file) { file = File.join( File.dirname(__FILE__), "support", "image.png" ) }

  describe "::fake?" do
    it do
      expect( described_class ).not_to be_fake
    end
  end

  describe "#faked?" do
    it do
      expect( described_class.new(100,100) ).not_to be_faked
      expect( 
        described_class.read(local_file).respond_to?(:faked) && 
        described_class.read(local_file).faked?
      ).to be false
    end
  end

end