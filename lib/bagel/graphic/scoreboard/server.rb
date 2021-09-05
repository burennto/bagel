module Bagel
  module Graphic
    class Scoreboard::Server
      WIDTH = 10
      HEIGHT = 50

      def initialize(is_server)
        @is_server = is_server
      end

      def draw
        Image.new(WIDTH, HEIGHT) { |i| i.background_color = @is_server ? COLOR_ORANGE : COLOR_GREY }
      end
    end
  end
end
