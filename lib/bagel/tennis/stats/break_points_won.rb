module Bagel::Tennis::Stats
  class BreakPointsWon < Stat
    private attr_reader :p1_label, :p2_label, :p1_percentage, :p2_percentage

    def name
      'BREAK POINTS WON'
    end

    def values
      [ p1_label, p2_label ]
    end

    def superior
      [ p1_percentage > p2_percentage, p2_percentage > p1_percentage ]
    end

    private

    def calculate
      p1_break_points = points.select(&:break_point?).select(&:p2_serve?)
      p2_break_points = points.select(&:break_point?).select(&:p1_serve?)

      p1_break_points_won = p1_break_points.select(&:p1_won?)
      p2_break_points_won = p2_break_points.select(&:p2_won?)

      @p1_percentage = percentage(p1_break_points.count, p1_break_points_won.count)
      @p2_percentage = percentage(p2_break_points.count, p2_break_points_won.count)

      @p1_label = label(p1_break_points.count, p1_break_points_won.count, p1_percentage)
      @p2_label = label(p2_break_points.count, p2_break_points_won.count, p2_percentage)
    end
  end
end
