RSpec.describe Outcome do
  let(:ace)          { Outcome.new(winner: Player.ONE, reason: Outcome::WINNER, shot: Outcome::SERVE) }
  let(:double_fault) { Outcome.new(winner: Player.TWO, reason: Outcome::UNFORCED_ERROR, shot: Outcome::SERVE) }
  let(:fh_winner)    { Outcome.new(winner: Player.ONE, reason: Outcome::WINNER, shot: Outcome::FOREHAND) }
  let(:bh_error)     { Outcome.new(winner: Player.TWO, reason: Outcome::UNFORCED_ERROR, shot: Outcome::BACKHAND) }
  let(:net_point_a)  { Outcome.new(winner: Player.ONE, reason: Outcome::WINNER, shot: Outcome::FOREHAND, net: [true, false]) }
  let(:net_point_b)  { Outcome.new(winner: Player.TWO, reason: Outcome::WINNER, shot: Outcome::FOREHAND, net: [nil, true]) }

  describe '#ace?' do
    it 'returns a boolean representing whether the point was an ace' do
      expect(ace.ace?).to eq true
      expect(double_fault.ace?).to eq false
      expect(fh_winner.ace?).to eq false
      expect(bh_error.ace?).to eq false
    end
  end

  describe '#winner?' do
    it 'returns a boolean representing whether the final shot was a winner' do
      expect(ace.winner?).to eq true
      expect(double_fault.winner?).to eq false
      expect(fh_winner.winner?).to eq true
      expect(bh_error.winner?).to eq false
    end
  end

  describe '#unforced_error?' do
    it 'returns a boolean representing whether the final shot was an unforced error' do
      expect(ace.unforced_error?).to eq false
      expect(double_fault.unforced_error?).to eq true
      expect(fh_winner.unforced_error?).to eq false
      expect(bh_error.unforced_error?).to eq true
    end
  end

  describe '#p1_won?' do
    it 'returns a boolean representing whether the point was won by player 1' do
      expect(ace.p1_won?).to eq true
      expect(double_fault.p1_won?).to eq false
      expect(fh_winner.p1_won?).to eq true
      expect(bh_error.p1_won?).to eq false
    end
  end

  describe '#p2_won?' do
    it 'returns a boolean representing whether the point was won by player 2' do
      expect(ace.p2_won?).to eq false
      expect(double_fault.p2_won?).to eq true
      expect(fh_winner.p2_won?).to eq false
      expect(bh_error.p2_won?).to eq true
    end
  end

  describe '#p1_net_point?' do
    it 'returns a boolean or nil representing whether the point was a net point for player 1' do
      expect(net_point_a.p1_net_point?).to eq true
      expect(net_point_b.p1_net_point?).to eq false
    end
  end

  describe '#p2_net_point?' do
    it 'returns a boolean or nil representing whether the point was a net point for player 2' do
      expect(net_point_a.p2_net_point?).to eq true
      expect(net_point_b.p2_net_point?).to eq true
    end
  end
end
