module Bagel::Tennis::Stats
  class Stat
    private attr_reader :points

    def initialize(points)
      @points = points
      calculate
    end

    def name
      raise_not_implemented_error(self.class, __method__)
    end

    def values
      raise_not_implemented_error(self.class, __method__)
    end

    def superior
      raise_not_implemented_error(self.class, __method__)
    end

    private

    def raise_not_implemented_error(klass, method)
      raise NotImplementedError, "#{klass} has not implemented method '#{method}'"
    end

    def calculate
      raise_not_implemented_error(self.class, __method__)
    end

    def percentage(total, won)
      (won / total.to_f * 100).round rescue 0
    end

    def label(total, won, percentage)
      "#{won}/#{total} (#{percentage}%)"
    end
  end
end
