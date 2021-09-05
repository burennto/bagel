module Bagel::Video
  class Padding
    attr_reader :x, :y

    def initialize(attrs)
      @x, @y = attrs[:x], attrs[:y]
    end
  end
end
