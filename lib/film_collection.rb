class FilmCollection
  attr_reader :films

  def initialize(films)
    @films = films
  end

  def to_a
    @films
  end

  def film_of_this_director(selective_director)
    @films.select { |film| film.director == selective_director}.sample
  end
end
