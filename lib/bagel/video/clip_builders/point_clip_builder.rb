module Bagel::Video::ClipBuilders
  class PointClipBuilder < ClipBuilder
    private attr_reader :names, :score, :second_serve, :comment

    ID_SUFFIX = '-point'
    COMMENT_2ND_SERVE = '2nd SERVE'

    def set_id
      clip.id = "#{score.id}#{ID_SUFFIX}"
    end

    def add_clip_fade
      # no fade for point clips
    end

    def add_overlays
      add_scoreboard_overlay
      add_second_serve_overlay if second_serve
      add_comment_overlay if comment
    end

    private

    def post_initialize(data)
      @names = Bagel.config.names
      @score = Score.new(sets: data[:score].first, points: data[:score].last, server: data[:server])
      @second_serve = data[:faults] > 0
      @comment = data[:comment]
    end

    def add_scoreboard_overlay
      clip.overlays << scoreboard_overlay
    end

    def add_second_serve_overlay
      clip.overlays << second_serve_overlay
    end

    def add_comment_overlay
      clip.overlays << comment_overlay
    end

    def comment_overlay
      Overlays::Comment.new(comment_graphic)
    end

    def scoreboard_overlay
      Overlays::Scoreboard.new(scoreboard_graphic)
    end

    def second_serve_overlay
      Overlays::SecondServe.new(second_serve_graphic)
    end

    def scoreboard_graphic
      Graphic::Scoreboard.new(score, names).save
    end

    def second_serve_graphic
      @second_serve_graphic ||= Graphic::Comment.new(COMMENT_2ND_SERVE).save
    end

    def comment_graphic
      Graphic::Comment.new(comment.upcase).save
    end
  end
end
