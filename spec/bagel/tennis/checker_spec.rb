RSpec.describe Checker do
  describe '#break_point?' do
    let(:checker_a_1) { Checker.new(sets: [[0, 0]], points: [0, 0], server: Player.ONE) }
    let(:checker_a_2) { Checker.new(sets: [[0, 0]], points: [3, 0], server: Player.ONE) }
    let(:checker_a_3) { Checker.new(sets: [[0, 0]], points: [0, 3], server: Player.ONE) }
    let(:checker_a_4) { Checker.new(sets: [[0, 0]], points: [3, 3], server: Player.ONE) }
    let(:checker_a_5) { Checker.new(sets: [[0, 0]], points: [4, 3], server: Player.ONE) }
    let(:checker_a_6) { Checker.new(sets: [[0, 0]], points: [3, 4], server: Player.ONE) }

    it 'returns a boolean representing whether or not the point is a break point' do
      expect(checker_a_1.break_point?).to eq false
      expect(checker_a_2.break_point?).to eq false
      expect(checker_a_3.break_point?).to eq true
      expect(checker_a_4.break_point?).to eq false
      expect(checker_a_5.break_point?).to eq false
      expect(checker_a_6.break_point?).to eq true
    end
  end

  describe '#set_point?' do
    let(:checker_b_1) { Checker.new(sets: [[5, 0]], points: [3, 0], server: Player.ONE) }
    let(:checker_b_2) { Checker.new(sets: [[5, 5]], points: [3, 0], server: Player.ONE) }
    let(:checker_b_3) { Checker.new(sets: [[6, 5]], points: [3, 0], server: Player.ONE) }

    it 'returns a boolean representing whether or not the point is a set point' do
      expect(checker_b_1.set_point?).to eq true
      expect(checker_b_2.set_point?).to eq false
      expect(checker_b_3.set_point?).to eq true
    end
  end

  describe '#match_point?' do
    let(:checker_c_1) { Checker.new(sets: [[6, 0], [5, 0]], points: [3, 0], server: Player.ONE) }
    let(:checker_c_2) { Checker.new(sets: [[0, 6], [5, 0]], points: [3, 0], server: Player.ONE) }
    let(:checker_c_3) { Checker.new(sets: [[6, 0], [0, 6], [5, 0]], points: [3, 0], server: Player.ONE) }

    it 'returns a boolean representing whether or not the point is a match point' do
      expect(checker_c_1.match_point?).to eq true
      expect(checker_c_2.match_point?).to eq false
      expect(checker_c_3.match_point?).to eq true
    end
  end

  describe '#tiebreak?' do
    let(:checker_d_1) { Checker.new(sets: [[0, 0]], points: [0, 0], server: Player.ONE) }
    let(:checker_d_2) { Checker.new(sets: [[3, 3]], points: [0, 0], server: Player.ONE) }
    let(:checker_d_3) { Checker.new(sets: [[6, 6]], points: [0, 0], server: Player.ONE) }
    let(:checker_d_4) { Checker.new(sets: [[6, 0], [0, 0]], points: [0, 0], server: Player.ONE) }
    let(:checker_d_5) { Checker.new(sets: [[6, 0], [6, 6]], points: [0, 0], server: Player.ONE) }

    it 'returns a boolean representing whether or not the point is part of a tiebreak' do
      expect(checker_d_1.tiebreak?).to eq false
      expect(checker_d_2.tiebreak?).to eq false
      expect(checker_d_3.tiebreak?).to eq true
      expect(checker_d_4.tiebreak?).to eq false
      expect(checker_d_5.tiebreak?).to eq true
    end
  end
end
