module Bagel::Video::Overlays
  class Scoreboard < Overlay
    def orientation
      Orientation::BOTTOM_LEFT
    end

    def padding
      Padding.new(x: 50, y: 50)
    end

    def fade
      @fade ? Fade.new(out_start: 3, out_duration: 1.5) : nil
    end
  end
end
