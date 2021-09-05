# frozen_string_literal: true

RSpec.describe Bagel do
  it 'has a version number' do
    expect(Bagel::VERSION).not_to be nil
  end

  describe '.make_video' do
    let(:parser) { double(ClipDataParser) }
    let(:clips) { [ double(Clip), double(Clip) ] }
    let(:video) { double(Video::Video) }

    before(:each) do
      allow(Bagel).to receive_message_chain(:config, :clip_data).and_return('path/to/yaml.file')
      allow(ClipDataParser).to receive(:new).and_return(parser)
      allow(parser).to receive(:parse_clips).and_return(clips)
      allow(Video::Video).to receive(:new).and_return(video)
      allow(video).to receive(:save)
    end

    it 'parses the clip data' do
      expect(ClipDataParser).to receive(:new).with('path/to/yaml.file')
      Bagel.make_video
    end

    it 'instantiates a new video' do
      expect(Video::Video).to receive(:new).with(clips)
      Bagel.make_video
    end

    it 'saves the video' do
      expect(video).to receive(:save)
      Bagel.make_video
    end
  end
end
