require "spec_helper"

RSpec.describe FakeFS::Magick do
  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
  end

  describe "#activated?" do
    context "by default" do
      it do
        expect(described_class.activated?).to be false
      end
      it "does not fake Magick::Image" do
        expect(::Magick::Image).not_to be_fake
      end
    end
    context "after being activated" do
      it do
        begin
          described_class.activate!
          expect(described_class.activated?).to be true
        ensure
          described_class.deactivate!
        end
      end
      it "does fake Magick::Image" do
        begin
          expect(::Magick::Image).not_to be_fake
          described_class.activate!
          expect(::Magick::Image).to be_fake
        ensure
          described_class.deactivate!
        end
      end
    end
    context "after being deactivated" do
      it do
        described_class.activate!
        described_class.deactivate!
        expect(described_class.activated?).to be false
      end
      it "does not fake Magick::Image" do
        described_class.activate!
        described_class.deactivate!
        expect(::Magick::Image).not_to be_fake
      end
    end
  end

  describe "#activate!" do
    it "does fake Magick::Image" do
      begin
        expect(::Magick::Image).not_to be_fake
        described_class.activate!
        expect(::Magick::Image).to be_fake
      ensure
        described_class.deactivate!
      end
    end
  end

  describe "#deactivate!" do
    it "restores Magick::Image" do
      described_class.activate!
      described_class.deactivate!
      expect(::Magick::Image).not_to be_fake
    end
  end

  describe "#hook!" do
    it "install hook" do
      begin
        described_class.hook!
        expect(FakeFS.respond_to?(:with_rmagick_hook?)).to be true
      ensure
        described_class.deactivate_hook!
      end
    end
    context "FakeFS activated" do
      it "does fake Magick::Image" do
        begin
          described_class.hook!
          expect(::Magick::Image).not_to be_fake
          FakeFS.activate!
          expect(::Magick::Image).to be_fake
        ensure
          FakeFS.deactivate!
          described_class.deactivate_hook!
        end
      end
    end
    context "FakeFS deactivated" do
      it "does not fake Magick::Image" do
        begin
          described_class.hook!
          FakeFS.activate!
          FakeFS.deactivate!
          expect(::Magick::Image).not_to be_fake
        ensure
          described_class.deactivate_hook!
        end
      end
    end
  end

  describe "#deactivate_hook!" do
    it "does not fake Magick::Image" do
      begin
        described_class.hook!
        described_class.deactivate_hook!
        FakeFS.activate!
        expect(::Magick::Image).not_to be_fake
      ensure
        FakeFS.deactivate!
      end
    end 
  end

  describe "#hook_activated?" do
    context "hook activated" do
      it do
        begin
          described_class.hook!
          expect(described_class).to be_hook_activated
        ensure
          described_class.deactivate_hook!
        end
      end
    end
    context "hook deactivated" do
      it do
        described_class.hook!
        described_class.deactivate_hook!
        expect(described_class).not_to be_hook_activated
      end
    end
  end


  describe "#with" do
    context "in the block given" do
      it "does fake Magick::Image" do
        expect(::Magick::Image).not_to be_fake
        described_class.with do
          expect(::Magick::Image).to be_fake
        end
      end
    end
    context "after execution" do
      it "does not fake Magick::Image" do
        described_class.with do
          #nothing
        end
        expect(::Magick::Image).not_to be_fake
      end
    end
  end



end
