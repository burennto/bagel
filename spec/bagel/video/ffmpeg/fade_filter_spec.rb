RSpec.describe FadeFilter do

  describe '#to_s' do
    let(:fade) { double(Fade, in_start: '01:00', in_duration: 8, out_start: '01:30', out_duration: 5) }
    subject(:filter) { FadeFilter.new(0, fade, 'v', false) }

    it 'generates the correct FFMPEG filter syntax' do
      expect(filter.to_s).to eq '[0]fade=t=in:st=01:00:d=8:alpha=0,fade=t=out:st=01:30:d=5:alpha=0[v]'
    end
  end

end
