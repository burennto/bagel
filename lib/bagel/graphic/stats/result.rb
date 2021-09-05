module Bagel
  module Graphic
    class Stats::Result
      WIDTH = Stats::WIDTH
      HEIGHT = 70

      COLOR_BG = COLOR_GREY
      COLOR_TEXT = COLOR_WHITE

      def initialize(names, games)
        @names = names.map(&:upcase)
        @games = games

        @d = Magick::Draw.new do |d|
          d.font_family = FONT_FAMILY
          d.pointsize = 36
          d.gravity = Magick::CenterGravity
          d.fill = COLOR_TEXT
        end
      end

      def draw
        canvas = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }
        canvas.composite!(cell(@names.first), WestGravity, 0, 0, OverCompositeOp)
        canvas.composite!(cell(@games.join(' - '), 72), CenterGravity, 0, 0, OverCompositeOp)
        canvas.composite!(cell(@names.last), EastGravity, 0, 0, OverCompositeOp)
      end

      private

      def cell(value, font_size=36)
        cell = Image.new(WIDTH/3, HEIGHT) { |i| i.background_color = COLOR_BG }
        text = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }
        @d.pointsize = font_size
        @d.annotate(text, 0, 0, 0, 0, value)
        text.trim!
        cell.composite!(text, CenterGravity, 0, 0, OverCompositeOp)
      end
    end
  end
end
