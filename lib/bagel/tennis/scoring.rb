module Bagel::Tennis
  module Scoring
    LOVE = '0'
    FIFTEEN = '15'
    THIRTY = '30'
    FORTY = '40'
    FORTY_BLANK = ''
    ADVANTAGE = 'A'

    def self.point_call(player, opponent, tiebreak=false)
      return player.to_s if tiebreak

      return LOVE if player == 0
      return FIFTEEN if player == 1
      return THIRTY if player == 2

      if opponent < 3 || player == opponent
        FORTY
      elsif player < opponent
        FORTY_BLANK
      else
        ADVANTAGE
      end
    end
  end
end
