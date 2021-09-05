RSpec.describe Clip do

  subject(:clip) { Clip.new(timeframe) }
  let(:timeframe) { Timeframe.new('01:00', '01:30') }

  before(:each) do
    clip.id = '1'
  end

  describe '#save' do
    let(:clip_saver) { double(ClipSaver) }

    before(:each) do
      allow(ClipSaver).to receive(:new).and_return(clip_saver)
      allow(clip_saver).to receive(:save)
    end

    it 'instantiates a ClipSaver and calls save' do
      expect(ClipSaver).to receive(:new).with(clip)
      expect(clip_saver).to receive(:save)
      clip.save
    end
  end

  describe '#start' do
    it 'returns the starting timestamp' do
      expect(clip.start).to eq '01:00'
    end
  end

  describe '#duration' do
    it 'returns the timeframe duration' do
      expect(clip.duration).to eq 30
    end
  end

  describe '#trim_path' do
    before(:each) do
      allow(Bagel).to receive_message_chain(:config, :trim_dir).and_return('tmp/trims')
    end

    it 'returns the path where the trim should be stored' do
      expect(clip.trim_path).to eq 'tmp/trims/1.mp4'
    end
  end

  describe '#clip_path' do
    before(:each) do
      allow(Bagel).to receive_message_chain(:config, :clip_dir).and_return('tmp/clips')
    end

    it 'returns the path where the clip should be stored' do
      expect(clip.clip_path).to eq 'tmp/clips/1.mp4'
    end
  end

end
