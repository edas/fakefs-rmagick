require "rmagick"
require "fakefs_rmagick/real_image"

module FakeFSRmagick

  module FakeImageInstance

    def write(file)
      m = file.match /(?:^([a-zA-Z0-9]+):)|(?:\.([a-zA-Z0-9]+)$)/
      myformat = (m[1] || m[2]).sub("jpg", "jpeg").upcase if m
      File.write(file.sub(/^([a-zA-Z0-9]+):/, ''), to_blob {
        self.format = myformat if m
        yield if block_given?
      })
      self
    end

    def faked?
      true
    end

  end

  module FakeImageClass

    def read(file, &block)
      from_blob(File.read(file, &block)).each do |image|
        image.extend(FakeImageInstance)
      end
    end

    def ping(file, &block)
      read(file, &block)
    end

    def fake?
      true
    end

  end

  class FakeImage < RealImage

    extend FakeImageClass
    include FakeImageInstance

  end

end
