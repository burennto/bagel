require 'bagel/video/ffmpeg/concat_file'

module Bagel::Video
  module FFMPEG
    INDEX_VIDEO = 0
    LABEL_VIDEO = 'v'
    LABEL_OVERLAY = 'o'

    def self.concat(source:, destination:, transcode: false)
      ConcatFile.create(source) do |path|
        command = "ffmpeg -y -f concat -safe 0"
        command << " -i #{path}"
        command << " -c copy" unless transcode
        command << " #{destination}"
        system(command)
      end
    end

    def self.trim(start:, source:, duration:, transcode: false, destination:)
      command = "ffmpeg -y"
      command << " -ss #{start}"
      command << " -i #{source}"
      command << " -to #{duration}"
      command << " -c copy" unless transcode
      command << " -avoid_negative_ts make_zero #{destination}"
      system(command)
    end

    def self.filter(inputs:, filters:, destination:)
      inputs = inputs.map { |input| "-i #{input} -loop 1" }.join(' ')
      filters = filters.join(';')

      command = "ffmpeg -y"
      command << " #{inputs}"
      command << " -filter_complex \"#{filters}\""
      command << " -c:a copy"
      command << " #{destination}"
      system(command)
    end
  end
end
