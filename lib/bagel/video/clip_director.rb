module Bagel::Video
  class ClipDirector
    private attr_reader :builder

    def initialize(builder)
      @builder = builder
    end

    def build_clip
      builder.set_id
      builder.add_clip_fade
      builder.add_overlays
      builder.clip
    end
  end
end
