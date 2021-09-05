RSpec.describe Point do
  subject(:point) { Point.new(timeframe: timeframe, score: score, serve: serve, outcome: outcome) }
  let(:timeframe) { double(Timeframe) }
  let(:score) { double(Score) }
  let(:serve) { double(Serve) }
  let(:outcome) { double(Outcome) }

  describe 'delegations to the timeframe' do
    it 'delegates #start' do
      expect(timeframe).to receive(:start)
      point.start
    end

    it 'delegates #finish' do
      expect(timeframe).to receive(:finish)
      point.finish
    end
  end

  describe 'delegations to the score' do
    it 'delegates #break_point?' do
      expect(score).to receive(:break_point?)
      point.break_point?
    end

    it 'delegates #set_point?' do
      expect(score).to receive(:set_point?)
      point.set_point?
    end

    it 'delegates #match_point?' do
      expect(score).to receive(:match_point?)
      point.match_point?
    end
  end

  describe 'delegations to the serve' do
    it 'delegates #server?' do
      expect(serve).to receive(:server?)
      point.server?
    end

    it 'delegates #no_faults?' do
      expect(serve).to receive(:no_faults?)
      point.no_faults?
    end

    it 'delegates #second_serve?' do
      expect(serve).to receive(:second_serve?)
      point.second_serve?
    end

    it 'delegates #double_fault?' do
      expect(serve).to receive(:double_fault?)
      point.double_fault?
    end

    it 'delegates #p1_serve?' do
      expect(serve).to receive(:p1_serve?)
      point.p1_serve?
    end

    it 'delegates #p2_serve?' do
      expect(serve).to receive(:p2_serve?)
      point.p2_serve?
    end
  end

  describe 'delegations to the outcome' do
    it 'delegates #ace?' do
      expect(outcome).to receive(:ace?)
      point.ace?
    end

    it 'delegates #p1_won?' do
      expect(outcome).to receive(:p1_won?)
      point.p1_won?
    end

    it 'delegates #p2_won?' do
      expect(outcome).to receive(:p2_won?)
      point.p2_won?
    end

    it 'delegates #winner?' do
      expect(outcome).to receive(:winner?)
      point.winner?
    end

    it 'delegates #unforced_error?' do
      expect(outcome).to receive(:unforced_error?)
      point.unforced_error?
    end

    it 'delegates #p1_net_point?' do
      expect(outcome).to receive(:p1_net_point?)
      point.p1_net_point?
    end

    it 'delegates #p2_net_point?' do
      expect(outcome).to receive(:p2_net_point?)
      point.p2_net_point?
     end
  end
end
