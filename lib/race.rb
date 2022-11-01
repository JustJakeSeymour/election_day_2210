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

  
end
