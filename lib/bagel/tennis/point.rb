module Bagel::Tennis
  class Point
    extend Forwardable

    def_delegators :@timeframe, :start, :finish
    def_delegators :@score, :break_point?, :set_point?, :match_point?
    def_delegators :@serve, :server?, :no_faults?, :second_serve?, :double_fault?, :p1_serve?, :p2_serve?
    def_delegators :@outcome, :ace?, :p1_won?, :p2_won?, :winner?, :unforced_error?, :p1_net_point?, :p2_net_point?

    def initialize(timeframe:, score:, serve:, outcome:)
      @timeframe = timeframe
      @score = score
      @serve = serve
      @outcome = outcome
    end
  end
end
