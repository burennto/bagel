module Bagel::Video::FFMPEG
  class FadeFilter
    private attr_reader :fade, :input_index, :label, :alpha

    def self.for_clip(fade)
      new(INDEX_VIDEO, fade, LABEL_VIDEO, false).to_s
    end

    def self.for_overlay(fade, input_index)
      new(input_index+1, fade, "#{LABEL_OVERLAY}#{input_index}", true).to_s
    end

    def initialize(input_index, fade, label, alpha=false)
      @input_index = input_index
      @fade = fade
      @label = label
      @alpha = alpha
    end

    def to_s
      chain = []

      if fade.in_start && fade.in_duration
        chain << "fade=t=in:st=#{fade.in_start}:d=#{fade.in_duration}:alpha=#{alpha ? '1' : '0'}"
      end

      if fade.out_start && fade.out_duration
        chain << "fade=t=out:st=#{fade.out_start}:d=#{fade.out_duration}:alpha=#{alpha ? '1' : '0'}"
      end

      "[#{input_index}]#{chain.join(',')}[#{label}]"
    end
  end
end
