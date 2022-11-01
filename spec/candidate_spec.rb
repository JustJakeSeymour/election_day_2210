require './lib/candidate'

RSpec.describe Candidate do
  let!(:diana) {Candidate.new({name: "Diana D", party: :democrat})}

  it 'initializes with a name and party' do
    expect(diana.name).to eq "Diana D"
    expect(diana.party).to eq :democrat
  end

  it 'starts with zero votes' do
    expect(diana.votes).to eq 0
  end

  it 'gets votes using a vote_for! method' do
    expect(diana.votes).to eq 0
    
    diana.vote_for!
    diana.vote_for!
    diana.vote_for!

    expect(diana.votes).to eq 3

    diana.vote_for!

    expect(diana.votes).to eq 4
  end  
end