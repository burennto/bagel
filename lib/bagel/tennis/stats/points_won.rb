module Bagel::Tennis::Stats
  class PointsWon < Stat
    private attr_reader :p1, :p2

    def name
      'POINTS WON'
    end

    def values
      [ p1, p2 ]
    end

    def superior
      [ p1 > p2, p2 > p1 ]
    end

    private

    def calculate
      @p1 = points.select(&:p1_won?).count
      @p2 = points.select(&:p2_won?).count
    end
  end
end
