module Bagel::Video
  class ClipBuilderFactory
    BUILDERS = {
      intro: Bagel::Video::ClipBuilders::IntroClipBuilder,
      point: Bagel::Video::ClipBuilders::PointClipBuilder,
      stats: Bagel::Video::ClipBuilders::StatsClipBuilder
    }

    def self.for(type, data)
      BUILDERS[type].new(data)
    end
  end
end
