require_relative "lib/film"
require_relative "lib/film_collection"
require_relative "lib/director_collection"
require_relative "lib/film_parser"

puts "Программа «Фильм на вечер»"

films = FilmParser.from_kinonews #список всех фильмов
list_of_directors = DirectorCollection.new(films.to_a) #список всех режиссеров

puts list_of_directors

puts "Фильм какого режиссера вы хотите сегодня посмотреть?"
user_input = gets.to_i

until (1..list_of_directors.size).include?(user_input)
  puts "Такого номера нет в списке!"
  user_input = gets.to_i
end
puts "\nИ сегодня вечером рекомендую посмотреть:"
puts films.film_of_this_director(list_of_directors.selective(user_input))
