module Bagel::Video::ClipBuilders
  class StatsClipBuilder < ClipBuilder
    private attr_reader :names, :score, :points

    ID_SUFFIX = '-stats'

    def set_id
      clip.id = "#{score.set_number.to_s.rjust(2, '0')}#{ID_SUFFIX}"
    end

    def add_clip_fade
      clip.fade = Fade.new(out_start: 10.5, out_duration: 1.5)
    end

    def add_overlays
      add_scoreboard_overlay
      add_stats_overlay
    end

    private

    def post_initialize(data)
      @names = Bagel.config.names
      @score = Score.new(sets: data[:score].first)
      @points = ClipDataParser.new(Bagel.config.clip_data).parse_points(score.set_number)
    end

    def add_scoreboard_overlay
      clip.overlays << scoreboard_overlay
    end

    def add_stats_overlay
      clip.overlays << stats_overlay
    end

    def scoreboard_overlay
      Overlays::Scoreboard.new(scoreboard_graphic, true)
    end

    def stats_overlay
      Overlays::Stats.new(stats_graphic)
    end

    def scoreboard_graphic
      Graphic::Scoreboard.new(score, names).save
    end

    def stats_graphic
      Graphic::Stats.new(
        names: Bagel.config.names,
        score: score,
        points: points
      ).save
    end
  end
end
