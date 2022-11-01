require './lib/candidate'
require './lib/race'
require './lib/election'

RSpec.describe Election do
  let!(:election) {Election.new('2022')}
  let!(:race1) {Race.new("Virginia District 4 Representative")}
  let!(:race2) {Race.new("Texas Governor")}
    
  it 'starts with the year and an empty array of races'do
    expect(election.year).to eq '2022'

    # question, which of the following tests is best practice?
    expect(election.races).to eq []
    expect(election.races.empty?).to be true
    expect(election.races.size).to be 0
  end
  
  it 'gets races added with add_race method' do
    expect(election.races).to eq []

    election.add_race(race1)
    expect(election.races).to eq [race1]
    
    election.add_race(race2)
    expect(election.races).to eq [race1, race2]
  end
  
  it 'displays all candidates throughout all races' do
    election.add_race(race1)
    election.add_race(race2)
    expect(election.candidates).to eq []
    
    candidate1 = race1.register_candidate!({name: "Diana D", party: :democrat})
    expect(election.candidates).to eq [candidate1]
    
    candidate2 = race1.register_candidate!({name: "Roberto R", party: :republican})
    expect(election.candidates).to eq [candidate1, candidate2]

    candidate3 = race2.register_candidate!({name: "Diego D", party: :democrat})
    expect(election.candidates).to eq [candidate1, candidate2, candidate3]

    candidate4 = race2.register_candidate!({name: "Rita R", party: :republican})
    expect(election.candidates).to eq [candidate1, candidate2, candidate3, candidate4]
    
    candidate5 = race2.register_candidate!({name: "Ida I", party: :independent})
    expect(election.candidates).to eq [candidate1, candidate2, candidate3, candidate4, candidate5]
  end

  it 'can display vote counts for each candidate' do
    election.add_race(race1)
    election.add_race(race2)
    candidate1 = race1.register_candidate!({name: "Diana D", party: :democrat})
    candidate2 = race1.register_candidate!({name: "Roberto R", party: :republican})
    candidate3 = race2.register_candidate!({name: "Diego D", party: :democrat})
    candidate4 = race2.register_candidate!({name: "Rita R", party: :republican})
    candidate5 = race2.register_candidate!({name: "Ida I", party: :independent})

    4.times {candidate1.vote_for!}
    1.times {candidate2.vote_for!}
    10.times {candidate3.vote_for!}
    6.times {candidate4.vote_for!}
    6.times {candidate5.vote_for!}
    expect(election.vote_counts).to eq ({
                                      "Diana D"=>4, 
                                      "Roberto R"=>1, 
                                      "Diego D"=>10, 
                                      "Rita R"=>6, 
                                      "Ida I"=>6
                                    })
  end

  describe 'election winners' do
    let!(:candidate1) {race1.register_candidate!({name: "Diana D", party: :democrat})}
    let!(:candidate2) {race1.register_candidate!({name: "Roberto R", party: :republican})}

    xit 'displays winners of all races, in an array' do
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
    
      race3 = Race.new("Colorado District 5 Representative")

      expect(election.winners).to eq [candidate1]
    end
  end
end