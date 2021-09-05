module Bagel
  module Graphic
    class Stats::Duration
      WIDTH = Stats::WIDTH
      HEIGHT = 90

      COLOR_BG = COLOR_GREY
      COLOR_TEXT = COLOR_WHITE

      def initialize(minutes)
        @minutes = minutes
      end

      def draw
        canvas = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }

        text = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }

        draw = Magick::Draw.new do |d|
          d.font_family = FONT_FAMILY
          d.pointsize = 32
          d.gravity = Magick::CenterGravity
          d.fill = COLOR_TEXT
        end

        draw.annotate(text, 0, 0, 0, 0, "SET TIME: #{@minutes} MINUTES")
        text.trim!

        canvas.composite!(text, CenterGravity, 0, 0, AtopCompositeOp)
      end
    end
  end
end
