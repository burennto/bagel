module Bagel::Video
  class Video
    private attr_reader :clips

    def initialize(clips)
      @clips = clips
    end

    def save
      clips.map(&:save)
      FFMPEG.concat(
        source: Bagel.config.clip_dir,
        destination: Bagel.config.destination_video,
        transcode: false
      )
    end
  end
end
