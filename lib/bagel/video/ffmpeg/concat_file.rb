module Bagel::Video::FFMPEG
  class ConcatFile
    MP4_PATTERN = '*.mp4'
    FFMPEG_FILE_DIRECTIVE_PREFIX = 'file' + ' '

    attr_reader :source

    def self.create(source, &block)
      new(source).create(&block)
    end

    def initialize(source)
      @source = source
    end

    def create
      Tempfile.create do |file|
        file.write(contents)
        file.flush
        yield(file.path)
      end
    end

    private

    def contents
      Dir.glob(MP4_PATTERN, base: source)
        .sort
        .map { |filename| ffmpeg_file_directive(filename) }
        .join("\n")
    end

    def ffmpeg_file_directive(filename)
      FFMPEG_FILE_DIRECTIVE_PREFIX + absolute_path(relative_path(filename))
    end

    def relative_path(filename)
      File.join(source, filename)
    end

    def absolute_path(path)
      File.expand_path(path)
    end
  end
end
