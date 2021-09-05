module Bagel
  module Graphic
    class Scoreboard::Name
      WIDTH = 160
      HEIGHT = 50

      PADDING = 10

      def initialize(name)
        @name = name
      end

      def draw
        text = Image.new(WIDTH, HEIGHT) { self.background_color = COLOR_GREY }

        draw = Magick::Draw.new do |d|
          d.font_family = FONT_FAMILY
          d.font_weight = FONT_WEIGHT
          d.pointsize = FONT_SIZE
          d.gravity = CenterGravity
          d.fill = COLOR_WHITE
        end

        draw.annotate(text, 0, 0, 0, 0, @name.upcase)
        text.trim!

        canvas = Image.new(WIDTH, HEIGHT) { self.background_color = COLOR_GREY }
        canvas.composite!(text, WestGravity, PADDING, 0, OverCompositeOp)
      end
    end
  end
end
