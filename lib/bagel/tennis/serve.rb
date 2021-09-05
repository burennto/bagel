module Bagel::Tennis
  class Serve
    NO_FAULT = 0
    DOUBLE_FAULT = 2

    private attr_reader :server, :faults

    def initialize(server:, faults:)
      @server, @faults = server, faults
    end

    def server?(player)
      server == player
    end

    def no_faults?
      faults == NO_FAULT
    end

    def second_serve?
      faults > NO_FAULT
    end

    def double_fault?
      faults == DOUBLE_FAULT
    end

    def p1_serve?
      server?(Player.ONE)
    end

    def p2_serve?
      server?(Player.TWO)
    end
  end
end
