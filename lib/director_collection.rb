class DirectorCollection
  attr_reader :directors

  def initialize(films)
    @directors = films.map(&:director).uniq
  end

  def to_s
    @directors.map.with_index(1) { |director, index| "#{index}. #{director}"}.join("\n")
  end

  def size
    @directors.size
  end

  def selective(user_input)
    @directors[user_input - 1]
  end
end
