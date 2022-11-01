class Candidate

  attr_reader :info, :votes

  def initialize(info)
    @info = info
    @votes = 0
  end

  def name
    self.info[:name]
  end
  
  def party
    self.info[:party]
  end

  def vote_for!
    @votes += 1
  end
end
