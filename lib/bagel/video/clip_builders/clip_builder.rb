module Bagel::Video::ClipBuilders
  class ClipBuilder
    attr_reader :clip

    def initialize(data)
      @clip = Video::Clip.new(Timeframe.new(data[:start], data[:finish]))
      post_initialize(data)
    end

    def set_id
      raise_not_implemented_error(self.class, __method__)
    end

    def add_clip_fade
      raise_not_implemented_error(self.class, __method__)
    end

    def add_overlays
      raise_not_implemented_error(self.class, __method__)
    end

    private

    def post_initialize(data)
      raise_not_implemented_error(self.class, __method__)
    end

    def raise_not_implemented_error(klass, method)
      raise NotImplementedError, "#{klass} has not implemented method '#{method}'"
    end
  end
end
