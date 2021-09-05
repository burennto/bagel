module Bagel::Tennis::Stats
  class DoubleFaults < Stat
    private attr_reader :p1, :p2

    def name
      'DOUBLE FAULTS'
    end

    def values
      [ p1, p2 ]
    end

    def superior
      [ p1 < p2, p2 < p1 ]
    end

    private

    def calculate
      @p1 = double_faults(Player.ONE)
      @p2 = double_faults(Player.TWO)
    end

    def double_faults(player)
      points.count { |point| point.server?(player) && point.double_fault? }
    end
  end
end
