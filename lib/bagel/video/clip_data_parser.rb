module Bagel::Video
  class ClipDataParser
    private attr_reader :file

    def initialize(file)
      @file = file
    end

    def parse_clips
      read_yaml.map { |data| parse_clip(data) }
    end

    def parse_points(set_number)
      read_yaml
        .select { |data| data[:type] == 'point' }
        .select { |data| data[:score].first.length == set_number }
        .map do |data|
          Point.new(
            timeframe: Timeframe.new(data[:start], data[:finish]),
            score: Score.new(sets: data[:score].first, points: data[:score].last, server: data[:server]),
            serve: Serve.new(server: data[:server], faults: data[:faults]),
            outcome: Outcome.new(winner: data[:winner], reason: data[:reason], shot: data[:shot], net: data[:net])
          )
        end
    end

    private

    def read_yaml
      YAML.safe_load_file(file, symbolize_names: true)
    end

    def parse_clip(data)
      builder = ClipBuilderFactory.for(data[:type].to_sym, data)
      director = ClipDirector.new(builder)
      director.build_clip
    end
  end
end
