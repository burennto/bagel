RSpec.describe OverlayFilter do

  describe '#to_s' do
    let(:fade) { double(Fade, in_start: '01:00', in_duration: 8, out_start: '01:30', out_duration: 5) }
    let(:padding) { double(Padding, x: 10, y: 20 ) }

    context 'when orientation is :top_left' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :top_left, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=(10):y=(20):shortest=1[vo1]'
      end
    end

    context 'when orientation is :bottom_left' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :bottom_left, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=(10):y=(main_h-overlay_h-20):shortest=1[vo1]'
      end
    end

    context 'when orientation is :top_right' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :top_right, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=(main_w-overlay_w-10):y=(20):shortest=1[vo1]'
      end
    end

    context 'when orientation is :bottom_right' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :bottom_right, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=(main_w-overlay_w-10):y=(main_h-overlay_h-20):shortest=1[vo1]'
      end
    end

    context 'when orientation is :center' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :center, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=((main_w-overlay_w)/2):y=((main_h-overlay_h)/2):shortest=1[vo1]'
      end
    end

    context 'when orientation is :bottom' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :bottom, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=((main_w-overlay_w)/2):y=(main_h-overlay_h-20):shortest=1[vo1]'
      end
    end

    context 'when is_last is false' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :center, index: 0, is_last: false)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=((main_w-overlay_w)/2):y=((main_h-overlay_h)/2):shortest=1[vo1]'
      end
    end

    context 'when is_last is true' do
      subject(:filter) do
        OverlayFilter.new(fade: fade, padding: padding, orientation: :center, index: 0, is_last: true)
      end

      it 'generates the correct FFMPEG filter syntax' do
        expect(filter.to_s).to eq '[v][o0]overlay=x=((main_w-overlay_w)/2):y=((main_h-overlay_h)/2):shortest=1'
      end
    end
  end

end
