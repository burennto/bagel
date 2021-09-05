RSpec.describe Serve do
  let(:serve_1) { Serve.new(server: Player.ONE, faults: 0) }
  let(:serve_2) { Serve.new(server: Player.ONE, faults: 1) }
  let(:serve_3) { Serve.new(server: Player.TWO, faults: 2) }

  describe '#server?' do
    it 'returns a boolean representing if a given player is the server' do
      expect(serve_1.server?(Player.ONE)).to be true
      expect(serve_1.server?(Player.TWO)).to be false
      expect(serve_2.server?(Player.ONE)).to be true
      expect(serve_2.server?(Player.TWO)).to be false
      expect(serve_3.server?(Player.ONE)).to be false
      expect(serve_3.server?(Player.TWO)).to be true
    end
  end

  describe '#no_faults?' do
    it 'returns a boolean representing if there were no faults' do
      expect(serve_1.no_faults?).to be true
      expect(serve_2.no_faults?).to be false
      expect(serve_3.no_faults?).to be false
    end
  end

  describe '#second_serve?' do
    it 'returns a boolean representing if there was a second serve' do
      expect(serve_1.second_serve?).to be false
      expect(serve_2.second_serve?).to be true
      expect(serve_3.second_serve?).to be true
    end
  end

  describe '#double_fault?' do
    it 'returns a boolean representing if there was a double fault' do
      expect(serve_1.double_fault?).to be false
      expect(serve_2.double_fault?).to be false
      expect(serve_3.double_fault?).to be true
    end
  end

  describe '#p1_serve?' do
    it 'returns a boolean representing if player 1 was the server' do
      expect(serve_1.p1_serve?).to be true
      expect(serve_2.p1_serve?).to be true
      expect(serve_3.p1_serve?).to be false
    end
  end

  describe '#p2_serve?' do
    it 'returns a boolean representing if player 2 was the server' do
      expect(serve_1.p2_serve?).to be false
      expect(serve_2.p2_serve?).to be false
      expect(serve_3.p2_serve?).to be true
    end
  end
end
