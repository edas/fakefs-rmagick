require "rmagick"

module FakeFS
module Magick

  RealImage = ::Magick::Image

  module RealImageInstance
    def faked?
      false
    end
  end

  module RealImageClass
    def fake?
      false
    end
  end

  RealImage.include(RealImageInstance)
  RealImage.extend(RealImageClass)

end
end