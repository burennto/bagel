RSpec.describe Timeframe do
  describe '#duration' do
    subject(:timeframe) { Timeframe.new('1:00:00', '1:01:30') }
    it 'returns the duration in seconds' do
      expect(timeframe.duration).to eq 90
    end
  end

  describe '#duration_minutes' do
    subject(:timeframe) { Timeframe.new('05:30', '1:05:30') }
    it 'returns the duration in minutes' do
      expect(timeframe.duration_minutes).to eq 60
    end
  end
end
