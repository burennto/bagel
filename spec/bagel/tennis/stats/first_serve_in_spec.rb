RSpec.describe FirstServeIn do
  subject(:stat) { FirstServeIn.new(points) }

  let(:points) { ClipDataParser.new(file).parse_points(2) }
  let(:file) { 'spec/bagel/matches/match_1.yml' }

  describe '#name' do
    it 'returns the correct stat name' do
      expect(stat.name).to eq '1st SERVE IN'
    end
  end

  describe '#values' do
    it 'returns an array of values' do
      expect(stat.values).to eq ["12/22 (55%)", "23/36 (64%)"]
    end
  end

  describe '#superior' do
    it 'returns an array of booleans' do
      expect(stat.superior).to eq [ false, true ]
    end
  end
end
