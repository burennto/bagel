module Bagel::Video::Overlays
  class Intro < Overlay
    def orientation
      Orientation::BOTTOM_LEFT
    end

    def padding
      Padding.new(x: 80, y: 60)
    end

    def fade
      Fade.new(out_start: 5, out_duration: 1.5)
    end
  end
end
