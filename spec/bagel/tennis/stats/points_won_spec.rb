RSpec.describe PointsWon do
  subject(:stat) { PointsWon.new(points) }

  let(:points) { ClipDataParser.new(file).parse_points(2) }
  let(:file) { 'spec/bagel/matches/match_1.yml' }

  describe '#name' do
    it 'returns the correct stat name' do
      expect(stat.name).to eq 'POINTS WON'
    end
  end

  describe '#values' do
    it 'returns an array of values' do
      expect(stat.values).to eq [24, 34]
    end
  end

  describe '#superior' do
    it 'returns an array of booleans' do
      expect(stat.superior).to eq [ false, true ]
    end
  end
end
