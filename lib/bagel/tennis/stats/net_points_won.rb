module Bagel::Tennis::Stats
  class NetPointsWon < Stat
    private attr_reader :p1_label, :p2_label, :p1_percentage, :p2_percentage

    def name
      'NET POINTS WON'
    end

    def values
      [ p1_label, p2_label ]
    end

    def superior
      [ p1_percentage > p2_percentage, p2_percentage > p1_percentage ]
    end

    private

    def calculate
      p1_net_points = points.select(&:p1_net_point?)
      p2_net_points = points.select(&:p2_net_point?)

      p1_net_points_won = p1_net_points.select(&:p1_won?)
      p2_net_points_won = p2_net_points.select(&:p2_won?)

      @p1_percentage = percentage(p1_net_points.count, p1_net_points_won.count)
      @p2_percentage = percentage(p2_net_points.count, p2_net_points_won.count)

      @p1_label = label(p1_net_points.count, p1_net_points_won.count, p1_percentage)
      @p2_label = label(p2_net_points.count, p2_net_points_won.count, p2_percentage)
    end
  end
end
