RSpec.describe PointClipBuilder do

  subject(:builder) do
    PointClipBuilder.new(
      start: '01:00',
      finish: '02:00',
      score: [[[4, 2]], [3, 1]],
      faults: 1,
      comment: 'Lorem Ipsum'
    )
  end

  let(:scoreboard_graphic) { double(Graphic::Scoreboard, save: true) }
  let(:comment_graphic) { double(Graphic::Comment, save: true) }

  before(:each) do
    allow(Graphic::Scoreboard).to receive(:new).and_return(scoreboard_graphic)
    allow(Graphic::Comment).to receive(:new).and_return(comment_graphic)
  end

  describe '#set_id' do
    it 'sets the clip ID' do
      builder.set_id
      expect(builder.clip.id).to eq '01-07-05-point'
    end
  end

  describe '#add_clip_fade' do
    it 'does not add fade for point clips' do
      builder.add_clip_fade
      expect(builder.clip.fade).to be nil
    end
  end

  describe '#add_overlays' do
    it 'adds the overlays' do
      builder.add_overlays
      overlays = builder.clip.overlays
      expect(overlays.length).to eq 3
      expect(overlays[0]).to be_an_instance_of(Overlays::Scoreboard)
      expect(overlays[1]).to be_an_instance_of(Overlays::SecondServe)
      expect(overlays[2]).to be_an_instance_of(Overlays::Comment)
    end
  end

end
