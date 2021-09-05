RSpec.describe NetPointsWon do
  subject(:stat) { NetPointsWon.new(points) }

  let(:points) { ClipDataParser.new(file).parse_points(2) }
  let(:file) { 'spec/bagel/matches/match_1.yml' }

  describe '#name' do
    it 'returns the correct stat name' do
      expect(stat.name).to eq 'NET POINTS WON'
    end
  end

  describe '#values' do
    it 'returns an array of values' do
      expect(stat.values).to eq ["2/5 (40%)", "0/2 (0%)"]
    end
  end

  describe '#superior' do
    it 'returns an array of booleans' do
      expect(stat.superior).to eq [ true, false ]
    end
  end
end
