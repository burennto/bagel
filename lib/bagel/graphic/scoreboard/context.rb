module Bagel::Graphic
  class Scoreboard::Context
    HEIGHT = 40
    PADDING = 10

    def initialize(context)
      @context = context
    end

    def draw
      text = Image.new(HEIGHT * 10, HEIGHT * 2) { self.background_color = COLOR_WHITE }

      draw = Magick::Draw.new do |d|
        d.font_family = FONT_FAMILY
        d.font_weight = FONT_WEIGHT
        d.pointsize = 24
        d.gravity = WestGravity
        d.fill = COLOR_BLACK
      end

      draw.annotate(text, 0, 0, 0, 0, @context)
      text.trim!

      canvas = Image.new(text.columns + PADDING * 2, HEIGHT) { self.background_color = COLOR_WHITE }
      canvas.composite!(text, WestGravity, PADDING, 0, OverCompositeOp)
    end
  end
end
