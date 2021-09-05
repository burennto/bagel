RSpec.describe Score do
  describe '#id' do
    let(:score) { Score.new(sets: [[6, 3], [6, 7], [5, 3]], points: [0, 0], server: Player.ONE ) }
    it 'returns a unique identifier string in the format of set-game-point' do
      expect(score.id).to eq '03-09-01'
    end
  end

  describe '#context' do
    context 'when there is no context' do
      let(:score) { Score.new(sets: [[0, 0]], points: [0, 0], server: Player.ONE) }
      it 'returns nil' do
        expect(score.context).to be_nil
      end
    end

    context 'when the score is match point' do
      let(:score) { Score.new(sets: [[6, 0], [5, 0]], points: [3, 0], server: Player.ONE) }
      it 'returns MATCH POINT' do
        expect(score.context).to eq 'MATCH POINT'
      end
    end

    context 'when the score is set point' do
      let(:score) { Score.new(sets: [[5, 0]], points: [3, 0], server: Player.ONE) }
      it 'returns SET POINT' do
        expect(score.context).to eq 'SET POINT'
      end
    end

    context 'when the score is break point' do
      let(:score) { Score.new(sets: [[0, 0]], points: [0, 3], server: Player.ONE) }
      it 'returns BREAK POINT' do
        expect(score.context).to eq 'BREAK POINT'
      end
    end
  end

  describe '#server?' do
    let(:score) { Score.new(sets: [[0, 0]], points: [0, 3], server: Player.ONE) }
    it 'returns a boolean representing whether the player is serving or not' do
      expect(score.server?(Player.ONE)).to be true
      expect(score.server?(Player.TWO)).to be false
    end
  end

  describe '#set_number' do
    let(:score) { Score.new(sets: [[6, 0], [5, 0]], points: [3, 0], server: Player.ONE) }
    it 'returns the current set number' do
      expect(score.set_number).to eq 2
    end
  end

  describe '#set_score' do
    let(:score) { Score.new(sets: [[6, 0], [5, 0]], points: [3, 0], server: Player.ONE) }
    it 'returns the current set score' do
      expect(score.set_score).to eq [5, 0]
    end
  end

  describe 'special points' do
    let(:score_a) { Score.new(sets: [[0, 0]], points: [0, 3], server: Player.ONE) }
    let(:score_b) { Score.new(sets: [[5, 0]], points: [3, 0], server: Player.ONE) }
    let(:score_c) { Score.new(sets: [[6, 0], [5, 0]], points: [3, 0], server: Player.ONE) }

    describe '#break_point?' do
      it 'returns a boolean representing whether the score is break point' do
        expect(score_a.break_point?).to be true
        expect(score_b.break_point?).to be false
        expect(score_c.break_point?).to be false
      end
    end

    describe '#set_point?' do
      it 'returns a boolean representing whether the score is set point' do
        expect(score_a.set_point?).to be false
        expect(score_b.set_point?).to be true
        expect(score_c.set_point?).to be true
      end
    end

    describe '#match_point?' do
      it 'returns a boolean representing whether the score is match point' do
        expect(score_a.match_point?).to be false
        expect(score_b.match_point?).to be false
        expect(score_c.match_point?).to be true
      end
    end

    describe '#tiebreak?' do
      let(:score_d) { Score.new(sets: [[6, 6]], points: [3, 0], server: Player.ONE) }
      it 'returns a boolean representing whether the score is a tiebreak' do
        expect(score_a.tiebreak?).to be false
        expect(score_b.tiebreak?).to be false
        expect(score_c.tiebreak?).to be false
        expect(score_d.tiebreak?).to be true
      end
    end
  end
end
