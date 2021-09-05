RSpec.describe FFMPEG do
  describe '.concat' do
    let(:file) { double(FFMPEG::ConcatFile, path: 'path/to/concat_file') }

    before(:each) do
      allow(FFMPEG::ConcatFile).to receive(:create).and_yield(file.path)
      allow(FFMPEG).to receive(:system)
    end

    it 'instantiates a ConcatFile' do
      expect(FFMPEG::ConcatFile).to receive(:create).with('path/to/clips')
      FFMPEG.concat(source: 'path/to/clips', destination: 'path/to/out.mp4')
    end

    describe 'makes a system call to FFMPEG to concat' do
      it 'skips transcoding by default' do
        command = 'ffmpeg -y -f concat -safe 0 -i path/to/concat_file -c copy path/to/out.mp4'
        expect(FFMPEG).to receive(:system).with(command)
        FFMPEG.concat(source: 'path/to/clips', destination: 'path/to/out.mp4')
      end

      it 'can transcode by passing a flag' do
        command = 'ffmpeg -y -f concat -safe 0 -i path/to/concat_file path/to/out.mp4'
        expect(FFMPEG).to receive(:system).with(command)
        FFMPEG.concat(source: 'path/to/clips', destination: 'path/to/out.mp4', transcode: true)
      end
    end
  end

  describe '.trim' do
    it 'makes a system call to FFMPEG' do
      command = "ffmpeg -y -ss 10:00 -i in.mp4 -to 7 -c copy -avoid_negative_ts make_zero out.mp4"
      expect(FFMPEG).to receive(:system).with(command)
      FFMPEG.trim(start: '10:00', source: 'in.mp4', duration: 7, destination: 'out.mp4')
    end
  end
end
