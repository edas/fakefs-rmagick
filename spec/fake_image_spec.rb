require "spec_helper"
require "fileutils"

RSpec.describe FakeFSRmagick::FakeImage do

  let(:local_file) { file = File.join( File.dirname(__FILE__), "support", "image.png" ) }
  
  describe "::fake?" do 
    it do
      expect( described_class.fake? ).to be true
    end
  end

  describe "#faked?" do
    context "with a new image" do
      it do
        image = described_class.new(100, 100)
        expect( image.faked? ).to be true
      end
    end
  end
  
  describe "::read" do
    it "returns image objects" do
      described_class.read(local_file).each do |image|
        expect(image).to be_a(FakeFSRmagick::RealImage)
      end
    end
    it "fake image objects returned" do
      described_class.read(local_file).each do |image|
        expect(image).to be_faked
      end
    end
    context "with a fake fs" do
      pwd = FileUtils.pwd
      it "open from a fakefs" do
        FakeFS.with_fresh do
          FakeFS::FileSystem.clone(local_file)
          FileUtils.mkpath pwd
          Dir.chdir pwd
          FileUtils.cp local_file, "test.png"
          expect(described_class.read("test.png").size).to be > 0
        end
      end
    end
  end

  describe "::ping" do
    it "let access to rows and columns" do
      image = described_class.ping(local_file)[0]
      expect(image.rows).to be 300
      expect(image.columns).to be 400
    end
    context "with a fake fs" do
      pwd = FileUtils.pwd
      it "open from a fakefs" do
        FakeFS.with_fresh do
          FakeFS::FileSystem.clone(local_file)
          FileUtils.mkpath pwd
          Dir.chdir pwd
          FileUtils.cp local_file, "test.png"
          expect(described_class.read("test.png").size).to be > 0
        end
      end
    end
  end

  describe "#write" do
    context "with a fake fs" do
      pwd = FileUtils.pwd
      it "write to a fakefs" do
        image = nil
        FakeFS.with_fresh do
          FakeFS::FileSystem.clone(local_file)
          FileUtils.mkpath pwd
          Dir.chdir pwd
          image = described_class.read(local_file)[0]
          expect( File.exist?("test.png") ).to be false
          image.write("test.png")
          expect( File.exist?("test.png") ).to be true
        end
        expect( File.exist?("test.png") ).to be false
      end
    end
  end


end
