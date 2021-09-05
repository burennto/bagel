module Bagel::Tennis::Stats
  class Aces < Stat
    private attr_reader :p1, :p2

    def name
      'ACES'
    end

    def values
      [ p1, p2 ]
    end

    def superior
      [ p1 > p2, p2 > p1 ]
    end

    private

    def calculate
      @p1 = aces(Player.ONE)
      @p2 = aces(Player.TWO)
    end

    def aces(player)
      points.count { |point| point.server?(player) && point.ace? }
    end
  end
end
