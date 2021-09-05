module Bagel
  class Timeframe
    attr_reader :start, :finish

    SECONDS_IN_MINUTE = 60
    SECONDS_IN_HOUR = 3600

    def initialize(start, finish)
      @start = start
      @finish = finish
    end

    def duration
      seconds(finish) - seconds(start)
    end

    def duration_minutes
      duration / SECONDS_IN_MINUTE
    end

    private

    def seconds(timestamp)
      parts = timestamp.split(':')
      s = parts.pop
      m = parts.pop
      h = parts.pop
      (h.to_i * SECONDS_IN_HOUR) + (m.to_i * SECONDS_IN_MINUTE) + s.to_i
    end
  end
end
