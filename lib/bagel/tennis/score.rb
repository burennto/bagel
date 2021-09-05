module Bagel::Tennis
  class Score
    attr_reader :sets, :points
    private attr_reader :server, :checker

    def initialize(sets:, points: nil, server: nil)
      @sets, @points = sets, points
      @server = server
      @checker = Tennis::Checker.new(sets: sets, points: points, server: server)
    end

    def id
      id_parts.map { |i| i.to_s.rjust(2, '0') }.join('-')
    end

    def context
      return nil if server.nil?
      return Tennis::Checker::MATCH_POINT if match_point?
      return Tennis::Checker::SET_POINT if set_point?
      return Tennis::Checker::BREAK_POINT if break_point?
    end

    def server?(player_id)
      server == player_id
    end

    def set_number
      sets.count
    end

    def set_score
      sets.last
    end

    def break_point?
      checker.break_point?
    end

    def set_point?
      checker.set_point?
    end

    def match_point?
      checker.match_point?
    end

    def tiebreak?
      checker.tiebreak?
    end

    private

    def id_parts
      parts = [ set_number ]
      parts << game_number if points
      parts << point_number if points
      parts
    end

    def game_number
      sets.last.sum + 1
    end

    def point_number
      points.sum + 1
    end
  end
end
