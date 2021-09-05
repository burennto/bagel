RSpec.describe SecondServePointsWon do
  subject(:stat) { SecondServePointsWon.new(points) }

  let(:points) { ClipDataParser.new(file).parse_points(2) }
  let(:file) { 'spec/bagel/matches/match_1.yml' }

  describe '#name' do
    it 'returns the correct stat name' do
      expect(stat.name).to eq '2nd SERVE POINTS WON'
    end
  end

  describe '#values' do
    it 'returns an array of values' do
      expect(stat.values).to eq ["4/10 (40%)", "8/13 (62%)"]
    end
  end

  describe '#superior' do
    it 'returns an array of booleans' do
      expect(stat.superior).to eq [ false, true ]
    end
  end
end
