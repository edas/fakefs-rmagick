module FakeFS
module Magick

  module FakeFSHook
    def activate!
      FakeFS::Magick.activate! if with_rmagick_hook?
      super
    end

    def deactivate!
      super
      FakeFS::Magick.deactivate! if with_rmagick_hook?
    end

    def with_rmagick_hook?
      FakeFS::Magick.hook_activated?
    end

  end

end
end

