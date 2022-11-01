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

    candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})

    expect(race.candidates.size).to eq 2
    expect(race.candidates[0]).to be_a Candidate
  end
end