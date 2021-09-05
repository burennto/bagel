RSpec.describe FFMPEG::ConcatFile do
  describe '.create' do
    let(:instance) { double(FFMPEG::ConcatFile) }
    let(:block) { -> {} }

    before(:each) do
      allow(FFMPEG::ConcatFile).to receive(:new).and_return(instance)
      allow(instance).to receive(:create)
    end

    after(:each) do
      FFMPEG::ConcatFile.create('path/to/clips', &block)
    end

    it 'initializes a new instance ' do
      expect(FFMPEG::ConcatFile).to receive(:new).with('path/to/clips')
    end

    it 'calls #create on the new instance, passing on the block' do
      expect(instance).to receive(:create) do |&block|
        expect(block).to be(block)
      end
    end
  end

  describe '#create' do
    subject(:instance) { FFMPEG::ConcatFile.new('path/to/clips') }

    let(:tempfile) { double(Tempfile) }
    let(:tempfile_path) { 'path/to/tempfile' }

    let(:string) do
      [
        "file #{File.expand_path('path/to/clips/clip-1.mp4')}",
        "file #{File.expand_path('path/to/clips/clip-2.mp4')}"
      ].join("\n")
    end

    before(:each) do
      allow(Tempfile).to receive(:create).and_yield(tempfile)
      allow(tempfile).to receive(:write)
      allow(tempfile).to receive(:flush)
      allow(tempfile).to receive(:path).and_return(tempfile_path)
      allow(Dir).to receive(:glob).and_return(['clip-2.mp4', 'clip-1.mp4'])
    end

    it 'initializes a Tempfile' do
      expect(Tempfile).to receive(:create).and_yield(tempfile)
      instance.create {}
    end

    it 'writes every MP4 filename from the source directory to the temp file in sorted order' do
      expect(tempfile).to receive(:write).with(string)
      instance.create {}
    end

    it 'flushes the temp file' do
      expect(tempfile).to receive(:flush)
      instance.create {}
    end

    it 'yields the temp file path to the block' do
      expect{ |b| instance.create(&b) }.to yield_with_args(tempfile_path)
    end
  end
end
