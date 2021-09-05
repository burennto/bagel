module Bagel::Video
  class Clip
    attr_accessor :id, :fade, :overlays
    private attr_reader :timeframe

    EXTENSION = '.mp4'

    def initialize(timeframe)
      @id = nil
      @fade = nil
      @timeframe = timeframe
      @overlays = []
    end

    def save
      ClipSaver.new(self).save
    end

    def start
      timeframe.start
    end

    def duration
      timeframe.duration
    end

    def trim_path
      File.join(Bagel.config.trim_dir, filename)
    end

    def clip_path
      File.join(Bagel.config.clip_dir, filename)
    end

    private

    def filename
      "#{id}#{EXTENSION}"
    end
  end
end
