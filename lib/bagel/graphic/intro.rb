module Bagel::Graphic
  class Intro
    FILENAME = '00-intro.png'
    MARGIN_X = 0
    MARGIN_Y = 20

    def initialize(title='', description='')
      @title = title
      @description = description
    end

    def save
      top = Image.new(1920, 1080) { self.background_color = COLOR_TRANSPARENT }
      draw.font_weight = BoldWeight
      draw.pointsize = 64
      draw.annotate(top, 0, 0, 0, 0, @title.upcase)
      top.trim!

      bottom = Image.new(1920, 1080) { self.background_color = COLOR_TRANSPARENT }
      draw.font_weight = NormalWeight
      draw.pointsize = 48
      draw.annotate(bottom, 0, 0, 0, 0, @description)
      bottom.trim!

      height = top.rows + bottom.rows + MARGIN_Y
      canvas = Image.new(1920, height) { self.background_color = COLOR_TRANSPARENT }
      canvas.composite!(top, NorthWestGravity, MARGIN_X, 0, OverCompositeOp)
      canvas.composite!(bottom, SouthWestGravity, MARGIN_X, 0, OverCompositeOp)
      canvas.trim!
      canvas.write(path)

      path
    end

    private

    def draw
      @draw ||= Magick::Draw.new do |d|
        d.font_family = FONT_FAMILY
        d.gravity = WestGravity
        d.fill = COLOR_WHITE
      end
    end

    def path
      File.join(Bagel.config.graphic_dir, FILENAME)
    end
  end
end
