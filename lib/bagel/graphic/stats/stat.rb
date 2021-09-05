module Bagel::Graphic
  class Stats::Stat
    WIDTH = Stats::WIDTH
    HEIGHT = 65

    COLOR_TEXT = COLOR_WHITE
    COLOR_TEXT_HIGHLIGHT = COLOR_ORANGE

    def initialize(index, stat)
      @index = index
      @stat = stat

      @color_bg = @index.even? ? COLOR_GREY_LIGHT : COLOR_GREY_DARK

      @canvas = Image.new(WIDTH, HEIGHT) { |i| i.background_color = @color_bg }
      @d = Magick::Draw.new do |d|
        d.font_family = FONT_FAMILY
        d.pointsize = 36
        d.gravity = Magick::CenterGravity
        d.fill = COLOR_TEXT
      end
    end

    def draw
      left = cell(value: @stat.values[0], highlight: @stat.superior[0], is_small: false)
      center = cell(value: @stat.name, is_small: true)
      right = cell(value: @stat.values[1], highlight: @stat.superior[1], is_small: false)

      @canvas.composite!(left, WestGravity, 0, 0, OverCompositeOp)
      @canvas.composite!(center, CenterGravity, 0, 0, OverCompositeOp)
      @canvas.composite!(right, EastGravity, 0, 0, OverCompositeOp)
    end

    private

    def cell(args)
      cell = Image.new(WIDTH / 3, HEIGHT) { |i| i.background_color = @color_bg }
      text = Image.new(WIDTH, HEIGHT) { |i| i.background_color = @color_bg }

      @d.fill = args[:highlight] ? COLOR_TEXT_HIGHLIGHT : COLOR_TEXT
      @d.pointsize = 32 if args[:is_small]

      @d.annotate(text, 0, 0, 0, 0, args[:value].to_s)
      text.trim!
      cell.composite!(text, CenterGravity, 0, 0, OverCompositeOp)
    end
  end
end
