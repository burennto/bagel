module Bagel
  module Graphic
    class Scoreboard::Games < Scoreboard::Score
      def color_bg
        COLOR_ORANGE
      end

      def color_text
        COLOR_BLACK
      end
    end
  end
end
