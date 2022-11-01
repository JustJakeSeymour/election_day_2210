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
    expect(election.)
    election.add_race(race1)
    election.add_race(race2)
    
    
  end
  
  
end