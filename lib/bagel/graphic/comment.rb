module Bagel::Graphic
  class Comment
    HEIGHT = 40
    PADDING = 10

    FILENAME_PREFIX = 'comment-'

    def initialize(text)
      @text = text
    end

    def save
      text = Image.new(1920, 1080) { self.background_color = COLOR_WHITE }

      draw = Magick::Draw.new do |d|
        d.font_family = FONT_FAMILY
        d.font_weight = FONT_WEIGHT
        d.pointsize = 24
        d.gravity = CenterGravity
        d.fill = COLOR_BLACK
      end

      draw.annotate(text, 0, 0, 0, 0, @text)
      text.trim!

      canvas = Image.new(text.columns + PADDING * 2, HEIGHT) { self.background_color = COLOR_WHITE }
      canvas.composite!(text, CenterGravity, 0, 0, OverCompositeOp)

      canvas.write(path)

      path
    end

    private

    def filename
      name = @text.downcase
        .gsub(/[^\w\s_-]+/, '')
        .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
        .gsub(/\s+/, '-')

        FILENAME_PREFIX + name + FILENAME_EXTENSION
    end

    def path
      File.join(Bagel.config.graphic_dir, filename)
    end
  end
end
