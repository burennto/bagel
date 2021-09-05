module Bagel::Video::ClipBuilders
  class IntroClipBuilder < ClipBuilder
    private attr_reader :title, :description

    ID = '00-intro'

    def set_id
      clip.id = ID
    end

    def add_clip_fade
      clip.fade = Video::Fade.new(in_start: 0, in_duration: 1.5, out_start: 6.5, out_duration: 1.5)
    end

    def add_overlays
      add_intro_overlay
    end

    private

    def post_initialize(data)
      @title, @description = data[:title], data[:description]
    end

    def add_intro_overlay
      clip.overlays << intro_overlay
    end

    def intro_overlay
      Overlays::Intro.new(intro_graphic)
    end

    def intro_graphic
      Graphic::Intro.new(title, description).save
    end
  end
end
