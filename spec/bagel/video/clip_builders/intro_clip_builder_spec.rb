RSpec.describe IntroClipBuilder do

  subject(:builder) { IntroClipBuilder.new(start: '01:00', finish: '02:00', title: 'Title', description: 'Description') }
  let(:intro_graphic) { double(Graphic::Intro, save: true) }

  before(:each) do
    allow(Graphic::Intro).to receive(:new).and_return(intro_graphic)
  end

  describe '#set_id' do
    it 'sets the clip ID' do
      builder.set_id
      expect(builder.clip.id).to eq '00-intro'
    end
  end

  describe '#add_clip_fade' do
    it 'adds the clip fade' do
      fade = builder.add_clip_fade
      expect(fade.in_start).to eq 0
      expect(fade.in_duration).to eq 1.5
      expect(fade.out_start).to eq 6.5
      expect(fade.out_duration).to eq 1.5
    end
  end

  describe '#add_overlays' do
    it 'adds the overlays' do
      overlays = builder.add_overlays
      expect(overlays.length).to eq 1
      expect(overlays.first).to be_an_instance_of(Overlays::Intro)
    end
  end

end
