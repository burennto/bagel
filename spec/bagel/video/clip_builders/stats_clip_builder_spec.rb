RSpec.describe StatsClipBuilder do

  let(:config) do
    double('config', names: ['Alice', 'Bob'], clip_data: 'spec/bagel/matches/match_1.yml')
  end

  subject(:builder) do
    StatsClipBuilder.new(
      start: '01:00',
      finish: '02:00',
      score: [[[6, 4]], [0, 0]],
      comment: 'Lorem Ipsum'
    )
  end

  let(:scoreboard_graphic) { double(Graphic::Scoreboard, save: true) }
  let(:stats_graphic) { double(Graphic::Stats, save: true) }

  before(:each) do
    allow(Bagel).to receive(:config).and_return(config)
  end

  before(:each) do
    allow(Graphic::Scoreboard).to receive(:new).and_return(scoreboard_graphic)
    allow(Graphic::Stats).to receive(:new).and_return(stats_graphic)
  end

  describe '#set_id' do
    it 'sets the clip ID' do
      builder.set_id
      expect(builder.clip.id).to eq '01-stats'
    end
  end

  describe '#add_clip_fade' do
    it 'does not add fade for point clips' do
      fade = builder.add_clip_fade
      expect(fade.out_start).to eq 10.5
      expect(fade.out_duration).to eq 1.5
    end
  end

  describe '#add_overlays' do
    it 'adds the overlays' do
      builder.add_overlays
      overlays = builder.clip.overlays
      expect(overlays.length).to eq 2
      expect(overlays[0]).to be_an_instance_of(Overlays::Scoreboard)
      expect(overlays[1]).to be_an_instance_of(Overlays::Stats)
    end
  end

end
