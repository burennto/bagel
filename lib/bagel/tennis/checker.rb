module Bagel::Tennis
  class Checker
    BREAK_POINT = 'BREAK POINT'
    SET_POINT = 'SET POINT'
    MATCH_POINT = 'MATCH POINT'

    MINIMUM_POINTS_TO_WIN_GAME = 4
    MINIMUM_POINTS_TO_WIN_TIEBREAK = 7

    MINIMUM_GAMES_TO_WIN_SET = 6
    SETS_TO_WIN_MATCH = 2

    TIEBREAK_AT = [ MINIMUM_GAMES_TO_WIN_SET, MINIMUM_GAMES_TO_WIN_SET ]

    private attr_reader :sets, :points, :server, :receiver

    def initialize(sets:, points:, server:)
      @sets, @points, @server = sets, points, server
      @receiver = Player.opponent(server)
    end

    def break_point?
      next_point_wins_game?(receiver)
    end

    def set_point?
      next_point_wins_set?(server) || next_point_wins_set?(receiver)
    end

    def match_point?
      next_point_wins_match?(server) || next_point_wins_match?(receiver)
    end

    def tiebreak?
      sets.last == Tennis::Checker::TIEBREAK_AT
    end

    private

    def points_for(player)
      points[Player.index(player)]
    end

    def games_for(player, set)
      set[Player.index(player)]
    end

    def next_point_wins_game?(player)
      will_have_required_points?(player) && will_have_point_margin?(player)
    end

    def next_point_wins_set?(player)
      next_point_wins_game?(player) && next_game_wins_set?(player)
    end

    def next_game_wins_set?(player)
      will_have_required_games?(sets.last, player) && will_have_game_margin?(sets.last, player)
    end

    def next_point_wins_match?(player)
      next_point_wins_set?(player) && next_set_wins_match?(player)
    end

    def next_set_wins_match?(player)
      sets_won(player) + 1 == SETS_TO_WIN_MATCH
    end

    def will_have_required_points?(player)
      points_for(player) + 1 >= (tiebreak? ? MINIMUM_POINTS_TO_WIN_TIEBREAK : MINIMUM_POINTS_TO_WIN_GAME)
    end

    def will_have_required_games?(set, player)
      games_for(player, set) + 1 >= MINIMUM_GAMES_TO_WIN_SET
    end

    def will_have_point_margin?(player)
      points_for(player) - points_for(Player.opponent(player)) >= 1
    end

    def will_have_game_margin?(set, player)
      games_for(player, set) - games_for(Player.opponent(player), set) >= 1
    end

    def sets_won(player)
      sets.count { |set| won_set?(set, player) }
    end

    def won_set?(set, player)
      enough_games_won?(player, set) && more_games_than_opponent?(player, set)
    end

    def enough_games_won?(player, set)
      games_for(player, set) >= MINIMUM_GAMES_TO_WIN_SET
    end

    def more_games_than_opponent?(player, set)
      games_for(player, set) > games_for(Player.opponent(player), set)
    end
  end
end
