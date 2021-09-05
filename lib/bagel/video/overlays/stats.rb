module Bagel::Video::Overlays
  class Stats < Overlay
    def orientation
      Orientation::CENTER
    end

    def padding
      nil
    end

    def fade
      Fade.new(in_start: 3, in_duration: 1.5, out_start: 8, out_duration: 1.5)
    end
  end
end
