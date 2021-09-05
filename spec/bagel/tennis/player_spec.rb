RSpec.describe Player do

  describe '.ONE' do
    it 'returns 1' do
      expect(Player.ONE).to eq 1
    end
  end

  describe '.TWO' do
    it 'returns 2' do
      expect(Player.TWO).to eq 2
    end
  end

  describe '.index' do
    it 'returns the array index for the player' do
      expect(Player.index(Player.ONE)).to eq 0
      expect(Player.index(Player.TWO)).to eq 1
    end
  end

  describe '.opponent' do
    it 'returns the ID of the opponent' do
      expect(Player.opponent(Player.ONE)).to eq 2
      expect(Player.opponent(Player.TWO)).to eq 1
    end
  end

end
