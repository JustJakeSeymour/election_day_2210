class Race

  attr_reader :office, :candidates

  def initialize(office)
    @office = office
    @candidates = []
    @open = true
  end

  def register_candidate!(candidate)
    @candidates << Candidate.new(candidate)
    return @candidates.last
  end

  def open?
    @open
  end

  def close!
    @open = false
  end

  def winner
    if !@open
      candidates.max_by{|candidate| candidate.votes}
    else
      false
    end
  end

  

end
