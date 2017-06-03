module FakeFSRmagick
  module FakeFSHook
    def activate!
      FakeFSRmagick.activate! if with_rmagick_hook?
      super
    end

    def deactivate!
      super
      FakeFSRmagick.deactivate! if with_rmagick_hook?
    end

    def with_rmagick_hook?
      FakeFSRmagick.hook_activated?
    end

  end
end

