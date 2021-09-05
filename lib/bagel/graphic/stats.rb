module Bagel::Graphic
  class Stats
    WIDTH = 1440
    HEIGHT = 900

    COLOR_BG = COLOR_GREY

    FILENAME_SUFFIX = '-stats'

    private attr_reader :names, :score, :points

    def initialize(names:, score:, points:)
      @names = names
      @score = score
      @points = points

      @canvas = Image.new(WIDTH, HEIGHT) { |i| i.background_color = COLOR_BG }
      @offset_y = 0
    end

    def save
      add_header
      add_result
      add_duration

      add_stat(0, Bagel::Tennis::Stats::Aces.new(points))
      add_stat(1, Bagel::Tennis::Stats::DoubleFaults.new(points))
      add_stat(0, Bagel::Tennis::Stats::FirstServeIn.new(points))
      add_stat(1, Bagel::Tennis::Stats::FirstServePointsWon.new(points))
      add_stat(0, Bagel::Tennis::Stats::SecondServePointsWon.new(points))
      add_stat(1, Bagel::Tennis::Stats::Winners.new(points))
      add_stat(0, Bagel::Tennis::Stats::UnforcedErrors.new(points))
      add_stat(1, Bagel::Tennis::Stats::NetPointsWon.new(points))
      add_stat(0, Bagel::Tennis::Stats::BreakPointsWon.new(points))
      add_stat(1, Bagel::Tennis::Stats::PointsWon.new(points))

      @canvas.write(path)
      path
    end

    private

    def add_header
      graphic = Bagel::Graphic::Stats::Header.new(score.set_number).draw
      @canvas.composite!(graphic, NorthGravity, 0, @offset_y, OverCompositeOp)
      @offset_y += Stats::Header::HEIGHT
    end

    def add_result
      graphic = Bagel::Graphic::Stats::Result.new(names, score.set_score).draw
      @canvas.composite!(graphic, NorthGravity, 0, @offset_y, OverCompositeOp)
      @offset_y += Stats::Result::HEIGHT
    end

    def add_duration
      graphic = Bagel::Graphic::Stats::Duration.new(duration).draw
      @canvas.composite!(graphic, NorthGravity, 0, @offset_y, OverCompositeOp)
      @offset_y += Stats::Duration::HEIGHT
    end

    def add_stat(index, stat)
      row = Bagel::Graphic::Stats::Stat.new(index, stat).draw
      @canvas.composite!(row, NorthGravity, 0, @offset_y, OverCompositeOp)
      @offset_y += Stats::Stat::HEIGHT
    end

    def duration
      start, finish = points[0].start, points[-1].finish
      Timeframe.new(start, finish).duration_minutes
    end

    def filename
      "#{score.set_number.to_s.rjust(2, '0')}#{FILENAME_SUFFIX}#{FILENAME_EXTENSION}"
    end

    def path
      File.join(Bagel.config.graphic_dir, filename)
    end
  end
end
