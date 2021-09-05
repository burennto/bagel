module Bagel::Tennis::Stats
  class FirstServeIn < Stat
    private attr_reader :p1_label, :p2_label, :p1_percentage, :p2_percentage

    def name
      '1st SERVE IN'
    end

    def values
      [ p1_label, p2_label ]
    end

    def superior
      [ p1_percentage > p2_percentage, p2_percentage > p1_percentage ]
    end

    private

    def calculate
      p1_served = points.select(&:p1_serve?)
      p2_served = points.select(&:p2_serve?)

      p1_served_no_faults = p1_served.select(&:no_faults?)
      p2_served_no_faults = p2_served.select(&:no_faults?)

      @p1_percentage = percentage(p1_served.count, p1_served_no_faults.count)
      @p2_percentage = percentage(p2_served.count, p2_served_no_faults.count)

      @p1_label = label(p1_served.count, p1_served_no_faults.count, p1_percentage)
      @p2_label = label(p2_served.count, p2_served_no_faults.count, p2_percentage)
    end
  end
end
