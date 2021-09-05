module Bagel::Tennis
  class Player
    PLAYER_ONE = 1
    PLAYER_TWO = 2

    def self.ONE
      PLAYER_ONE
    end

    def self.TWO
      PLAYER_TWO
    end

    def self.index(id)
      id - 1
    end

    def self.opponent(id)
      id == PLAYER_ONE ? PLAYER_TWO : PLAYER_ONE
    end
  end
end
