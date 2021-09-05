module Bagel::Video
  class Fade
    attr_reader :in_start, :in_duration, :out_start, :out_duration

    def self.for_final_score
      new(out_start: 3, out_duration: 1.5)
    end

    def self.for_stats_overlay
      new(in_start: 3, in_duration: 1.5, out_start: 8, out_duration: 1.5)
    end

    def self.for_stats_clip
      new(out_start: 10.5, out_duration: 1.5)
    end

    def initialize(attrs)
      @in_start = attrs[:in_start]
      @in_duration = attrs[:in_duration]
      @out_start = attrs[:out_start]
      @out_duration = attrs[:out_duration]
    end
  end
end
