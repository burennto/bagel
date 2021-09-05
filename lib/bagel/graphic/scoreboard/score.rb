module Bagel
  module Graphic
    class Scoreboard::Score
      WIDTH = 50
      HEIGHT = 50

      def initialize(value)
        @value = value
      end

      def draw
        text = Image.new(HEIGHT * 2, HEIGHT * 2) { |i| i.background_color = color_bg }

        draw = Magick::Draw.new do |d|
          d.font_family = FONT_FAMILY
          d.font_weight = FONT_WEIGHT
          d.pointsize = FONT_SIZE
          d.gravity = CenterGravity
          d.fill = color_text
        end

        draw.annotate(text, 0, 0, 0, 0, @value.to_s)
        text.trim!

        canvas = Image.new(HEIGHT, HEIGHT) { |i| i.background_color = color_bg }
        canvas.composite!(text, CenterGravity, 0, 0, OverCompositeOp)
      end

      def color_bg
        raise 'abstract'
      end

      def color_text
        raise 'abstract'
      end
    end
  end
end
