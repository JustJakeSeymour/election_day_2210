require './lib/candidate'
require './lib/race'

RSpec.describe Race do
  let!(:race) {Race.new("Texas Governor")}

  it 'starts with the name of the office candidates are running for' do
    expect(race.office).to eq "Texas Governor"  
  end

  it 'starts with an empty array with no candidates' do
    expect(race.candidates).to eq []
  end

  it 'registers candidates, creating a new candidate object' do
    candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})

    expect(candidate1.class).to eq Candidate
    expect(candidate1.name).to eq "Diana D"
    expect(candidate1.party).to eq :democrat
  end

  it 'adds new candidate into the candidate array for the race' do
    expect(race.candidates).to eq []
    
    candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})

    expect(race.candidates.size).to eq 1
    expect(race.candidates).to eq [candidate1]
    expect(race.candidates[0]).to be_a Candidate

    candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})

    expect(race.candidates.size).to eq 2
    expect(race.candidates).to eq [candidate1, candidate2]
    expect(race.candidates[1]).to be_a Candidate
  end

  describe 'open, close, and winner feature' do
    let!(:race1) {Race.new("Texas Governor")}
    let!(:race2) {Race.new("Virginia District 4 Representative")}

    let!(:candidate1) {race1.register_candidate!({name: "Diana D", party: :democrat})}
    let!(:candidate2) {race1.register_candidate!({name: "Roberto R", party: :republican})}
    
    it 'knows if race is open using a method, open is default' do
      expect(race1.open?).to be true
    end

    it 'can close the race using a method' do
      expect(race1.open?).to be true
      
      race1.close!

      expect(race1.open?).to be false
    end

    it 'displays winner, but not until race is closed' do
      expect(race1.open?).to be true
      expect(race1.winner).to be false
      
      4.times {candidate1.vote_for!}
      1.times {candidate2.vote_for!}
      race1.close!
      
      expect(race1.open?).to be false
      expect(race1.winner).to be candidate1
    end

    it 'will not return a winner if the race is a tie or still open' do
      candidate3 = race2.register_candidate!({name: "Diego D", party: :democrat})
      candidate4 = race2.register_candidate!({name: "Rita R", party: :republican})
      candidate5 = race2.register_candidate!({name: "Ida I", party: :independent})

      4.times {candidate1.vote_for!}
      1.times {candidate2.vote_for!}
      1.times {candidate3.vote_for!}
      6.times {candidate4.vote_for!}
      6.times {candidate5.vote_for!}

      race1.close!
      race2.close!
      expect(race1.tie?).to be false

      expect(race2.tie?).to be true
      expect(rave2.winner).to be false
    
      race3 = Race.new("Colorado District 5 Representative")
      expect(race3.open?).to be true
      expect(race3.winner).to be false
    end
  end
end