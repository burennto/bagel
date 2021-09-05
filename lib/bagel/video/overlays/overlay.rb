module Bagel::Video::Overlays
  class Overlay
    attr_reader :asset

    def initialize(asset, fade=false)
      @asset = asset
      @fade = fade
    end

    def orientation
      raise_not_implemented_error(self.class, __method__)
    end

    def padding
      raise_not_implemented_error(self.class, __method__)
    end

    def fade
      raise_not_implemented_error(self.class, __method__)
    end

    private

    def raise_not_implemented_error(klass, method)
      raise NotImplementedError, "#{klass} has not implemented method '#{method}'"
    end
  end
end
