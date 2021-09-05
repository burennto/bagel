RSpec.describe Scoring do

  describe '.point_call' do
    context 'when the player has scored 0 points' do
      it 'returns 0' do
        expect(Scoring.point_call(0, 0)).to eq '0'
      end
    end

    context 'when the player has scored 1 point' do
      it 'returns 15' do
        expect(Scoring.point_call(1, 0)).to eq '15'
      end
    end

    context 'when the player has scored 2 points' do
      it 'returns 30' do
        expect(Scoring.point_call(2, 0)).to eq '30'
      end
    end

    context 'when the player has scored 3 points' do
      it 'returns 40' do
        expect(Scoring.point_call(3, 0)).to eq '40'
        expect(Scoring.point_call(3, 1)).to eq '40'
        expect(Scoring.point_call(3, 2)).to eq '40'
        expect(Scoring.point_call(3, 3)).to eq '40'
      end
    end

    context 'when the player has advantage' do
      it 'returns A' do
        expect(Scoring.point_call(4, 3)).to eq 'A'
      end
    end

    context 'when the opponent has advantage' do
      it 'returns blank' do
        expect(Scoring.point_call(3, 4)).to eq ''
      end
    end

    context 'when it is a tiebreak' do
      it 'returns the points' do
        expect(Scoring.point_call(0, 0, true)).to eq '0'
        expect(Scoring.point_call(1, 0, true)).to eq '1'
        expect(Scoring.point_call(2, 0, true)).to eq '2'
        expect(Scoring.point_call(3, 0, true)).to eq '3'
        expect(Scoring.point_call(4, 0, true)).to eq '4'
        expect(Scoring.point_call(5, 0, true)).to eq '5'
        expect(Scoring.point_call(6, 0, true)).to eq '6'
        expect(Scoring.point_call(7, 6, true)).to eq '7'
      end
    end
  end

end
