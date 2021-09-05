module Bagel::Tennis::Stats
  class SecondServePointsWon < Stat
    private attr_reader :p1_label, :p2_label, :p1_percentage, :p2_percentage

    def name
      '2nd SERVE POINTS WON'
    end

    def values
      [ p1_label, p2_label ]
    end

    def superior
      [ p1_percentage > p2_percentage, p2_percentage > p1_percentage ]
    end

    private

    def calculate
      p1_second_serves = points.select(&:p1_serve?).select(&:second_serve?)
      p2_second_serves = points.select(&:p2_serve?).select(&:second_serve?)

      p1_second_serves_won = p1_second_serves.select(&:p1_won?)
      p2_second_serves_won = p2_second_serves.select(&:p2_won?)

      @p1_percentage = percentage(p1_second_serves.count, p1_second_serves_won.count)
      @p2_percentage = percentage(p2_second_serves.count, p2_second_serves_won.count)

      @p1_label = label(p1_second_serves.count, p1_second_serves_won.count, p1_percentage)
      @p2_label = label(p2_second_serves.count, p2_second_serves_won.count, p2_percentage)
    end
  end
end
