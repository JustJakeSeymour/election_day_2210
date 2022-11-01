class Election

  attr_reader :year, 
              :races

  def initialize(year)
    @year = year
    @races = []
  end

  def add_race(race)
    @races << race
  end

  def candidates
    candidates = []
    @races.each do |race|
      race.candidates.select do |candidate|
        candidates << candidate
      end
    end
    candidates
  end

  def vote_counts
    hash = {}
    candidates.each{|candidate|
    hash[candidate.name] = candidate.votes
    }
    hash
  end
end
