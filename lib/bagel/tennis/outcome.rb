module Bagel::Tennis
  class Outcome
    SERVE = 'S'
    FOREHAND = 'FH'
    BACKHAND = 'BH'

    WINNER = 'W'
    FORCED_ERROR = 'FE'
    UNFORCED_ERROR = 'UE'

    private attr_reader :winner, :reason, :shot, :net

    def initialize(winner:, reason:, shot:, net: nil)
      @winner = winner
      @reason = reason
      @shot = shot
      @net = net
    end

    def ace?
      winner? && shot == SERVE
    end

    def winner?
      reason == WINNER
    end

    def unforced_error?
      reason == UNFORCED_ERROR
    end

    def p1_won?
      winner == Player.ONE
    end

    def p2_won?
      winner == Player.TWO
    end

    def p1_net_point?
      net && !net[Player.index(Player.ONE)].nil?
    end

    def p2_net_point?
      net && !net[Player.index(Player.TWO)].nil?
    end
  end
end
