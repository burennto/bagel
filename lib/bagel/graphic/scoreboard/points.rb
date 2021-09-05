module Bagel
  module Graphic
    class Scoreboard::Points < Scoreboard::Score
      def color_bg
        COLOR_WHITE
      end

      def color_text
        COLOR_BLACK
      end
    end
  end
end
