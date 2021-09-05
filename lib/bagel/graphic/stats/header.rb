module Bagel
  module Graphic
    class Stats::Header
      WIDTH = Stats::WIDTH
      HEIGHT = 90

      COLOR_BG = COLOR_GREY
      COLOR_TEXT = COLOR_WHITE

      def initialize(set_number)
        @set_number = set_number
      end

      def draw
        text = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }

        draw = Magick::Draw.new do |d|
          d.font_family = FONT_FAMILY
          d.pointsize = 36
          d.gravity = Magick::CenterGravity
          d.fill = COLOR_TEXT
        end

        draw.annotate(text, 0, 0, 0, 0, "SET #{@set_number} SUMMARY")
        text.trim!

        canvas = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }
        canvas.composite!(text, CenterGravity, 0, 0, OverCompositeOp)
      end
    end
  end
end
