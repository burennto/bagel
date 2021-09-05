module Bagel::Tennis::Stats
  class FirstServePointsWon < Stat
    private attr_reader :p1_label, :p2_label, :p1_percentage, :p2_percentage

    def name
      '1st SERVE POINTS WON'
    end

    def values
      [ p1_label, p2_label ]
    end

    def superior
      [ p1_percentage > p2_percentage, p2_percentage > p1_percentage ]
    end

    private

    def calculate
      p1_first_serves = points.select(&:p1_serve?).select(&:no_faults?)
      p2_first_serves = points.select(&:p2_serve?).select(&:no_faults?)

      p1_first_serves_won = p1_first_serves.select(&:p1_won?)
      p2_first_serves_won = p2_first_serves.select(&:p2_won?)

      @p1_percentage = percentage(p1_first_serves.count, p1_first_serves_won.count)
      @p2_percentage = percentage(p2_first_serves.count, p2_first_serves_won.count)

      @p1_label = label(p1_first_serves.count, p1_first_serves_won.count, p1_percentage)
      @p2_label = label(p2_first_serves.count, p2_first_serves_won.count, p2_percentage)
    end
  end
end
