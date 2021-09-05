module Bagel::Video::Overlays
  class Comment < Overlay
    def orientation
      Orientation::BOTTOM_RIGHT
    end

    def padding
      Padding.new(x: 50, y: 50)
    end

    def fade
      Fade.new(out_start: 2.5, out_duration: 0.5)
    end
  end
end
