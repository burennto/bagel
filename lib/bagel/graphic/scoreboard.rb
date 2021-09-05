module Bagel::Graphic
  class Scoreboard
    MARGIN = 3
    PADDING = 10

    FILENAME_SUFFIX = '-score'

    private attr_reader :score, :names

    def initialize(score, names)
      @score, @names = score, names
    end

    def save
      offset_y = Scoreboard::Context::HEIGHT + MARGIN

      width = Scoreboard::Server::WIDTH + Scoreboard::Name::WIDTH + (Scoreboard::Score::HEIGHT * 3) + (MARGIN * 3)
      height = (Scoreboard::Server::HEIGHT * 2) + Scoreboard::Context::HEIGHT + (MARGIN * 2)

      canvas = Image.new(width, height) { |i| i.background_color = COLOR_TRANSPARENT }

      margin_x = 0

      if score.context
        canvas.composite!(img_context, NorthWestGravity, 0, 0, OverCompositeOp)
      end

      canvas.composite!(img_server_a, NorthWestGravity, margin_x, offset_y, OverCompositeOp)
      canvas.composite!(img_server_b, SouthWestGravity, margin_x, 0, OverCompositeOp)

      margin_x += Scoreboard::Server::WIDTH

      canvas.composite!(img_name_a, NorthWestGravity, margin_x, offset_y, OverCompositeOp)
      canvas.composite!(img_name_b, SouthWestGravity, margin_x, 0, OverCompositeOp)

      margin_x += Scoreboard::Name::WIDTH + MARGIN

      score.sets.each do |set|
        canvas.composite!(img_games_a(set[0]), NorthWestGravity, margin_x, offset_y, OverCompositeOp)
        canvas.composite!(img_games_b(set[1]), SouthWestGravity, margin_x, 0, OverCompositeOp)
        margin_x += Scoreboard::Score::HEIGHT + MARGIN
      end

      if score.points
        canvas.composite!(img_points_a, NorthWestGravity, margin_x, offset_y, OverCompositeOp)
        canvas.composite!(img_points_b, SouthWestGravity, margin_x, 0, OverCompositeOp)
      end

      canvas.write(path)

      path
    end

    private

    def img_context
      @img_context ||= Scoreboard::Context.new(score.context).draw
    end

    def img_server_a
      @img_server_a ||= Scoreboard::Server.new(score.server?(Player.ONE)).draw
    end

    def img_server_b
      @img_server_b ||= Scoreboard::Server.new(score.server?(Player.TWO)).draw
    end

    def img_name_a
      @img_name_a ||= Scoreboard::Name.new(names[0]).draw
    end

    def img_name_b
      @img_name_b ||= Scoreboard::Name.new(names[1]).draw
    end

    def img_games_a(games)
      Scoreboard::Games.new(games).draw
    end

    def img_games_b(games)
      Scoreboard::Games.new(games).draw
    end

    def img_points_a
      points = Scoring.point_call(score.points[0], score.points[1], score.tiebreak?)
      Scoreboard::Points.new(points).draw
    end

    def img_points_b
      points = Scoring.point_call(score.points[1], score.points[0], score.tiebreak?)
      Scoreboard::Points.new(points).draw
    end

    def path
      File.join(Bagel.config.graphic_dir, filename)
    end

    def filename
      "#{score.id}#{FILENAME_SUFFIX}#{FILENAME_EXTENSION}"
    end
  end
end
