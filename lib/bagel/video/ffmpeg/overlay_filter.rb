module Bagel::Video::FFMPEG
  class OverlayFilter
    private attr_reader :fade, :padding, :orientation, :index, :is_last

    def initialize(fade:, padding:, orientation:, index:, is_last:)
      @fade = fade
      @padding = padding
      @orientation = orientation
      @index = index
      @is_last = is_last
    end

    def to_s
      bottom = LABEL_VIDEO
      bottom += (1..index).map { |n| LABEL_OVERLAY+n.to_s }.join if index > 0
      bottom = "[#{bottom}]"

      top = fade ? "[#{LABEL_OVERLAY}#{index}]" : "[#{index+1}]"

      label_out = "[#{LABEL_VIDEO + (1..index+1).map { |n| LABEL_OVERLAY+n.to_s }.join}]"
      label_out = '' if is_last

      "#{bottom}#{top}overlay=x=(#{position_x}):y=(#{position_y}):shortest=1#{label_out}"
    end

    private

    def padding_x
      padding ? padding.x : 0
    end

    def padding_y
      padding ? padding.y : 0
    end

    def position_x
      case orientation
      when :top_left, :bottom_left then padding_x
      when :top_right, :bottom_right then "main_w-overlay_w-#{padding_x}"
      when :center, :bottom then "(main_w-overlay_w)/2"
      end
    end

    def position_y
      case orientation
      when :top_left, :top_right then padding_y
      when :bottom_left, :bottom_right, :bottom then "main_h-overlay_h-#{padding_y}"
      when :center then "(main_h-overlay_h)/2"
      end
    end
  end
end
