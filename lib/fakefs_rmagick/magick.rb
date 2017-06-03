require "rmagick"

module FakeFSRmagick

  def self.activate!
    Magick.class_eval do
      remove_const(:Image)
      const_set(:Image, ::FakeFSRmagick::FakeImage)
    end
  end

  def self.deactivate!
    Magick.class_eval do
      remove_const(:Image)
      const_set(:Image, ::FakeFSRmagick::RealImage)
    end
  end

  def self.activated?
    ::Magick::Image == ::FakeFSRmagick::FakeImage
  end

  def self.with
    begin
      self.activate!
      yield
    ensure
      self.deactivate!
    end
  end

  def self.hook!
    FakeFS.singleton_class.prepend(FakeFSHook) unless FakeFS.respond_to?(:with_rmagick_hook?)
    @@with_hook = true
  end

  def self.hook_activated?
    @@with_hook
  end

  def self.deactivate_hook!
    @@with_hook = false
  end
  
end