require 'date'

BASE_RATING = 8.0

file_name = ARGV[0] || 'movies.txt'

abort("File #{file_name} not found.") unless File.exist?(file_name)

def rating_stars(rating)
  stars_amount = (rating * 10 - BASE_RATING * 10).to_i
  '*' * stars_amount
end

def string_to_date(date)
  Date.new(*date.split('-').map(&:to_i))
end

def movie_format(movie)
  "#{movie[:title]}: (#{movie[:date]}; #{movie[:genres].join('/')})" \
  " - #{movie[:length]} min"
end

movies = File.open(file_name, 'r').map do |line|
  movie_data = line.split('|')
  {
    link: movie_data[0],
    title: movie_data[1],
    year: movie_data[2].to_i,
    country: movie_data[3],
    date: string_to_date(movie_data[4]),
    genres: movie_data[5].split(','),
    length: movie_data[6].to_i,
    rating: movie_data[7].to_f,
    producer: movie_data[8],
    actors: movie_data[9].chomp.split(',')
  }
end

puts "\n\n5 самых длинных фильмов\n\n"
movies.sort_by { |movie| movie[:length] }
      .reverse
      .take(5)
      .each { |movie| puts movie_format(movie) }

puts "\n\n10 комедий\n\n"
movies.select { |movie| movie[:genres].include?('Comedy') }
      .sort_by { |movie| movie[:date] }
      .take(10)
      .each { |movie| puts movie_format(movie) }

puts "\n\nСписок всех режиссёров\n\n"
movies.map { |movie| movie[:producer] }
      .uniq
      .sort_by { |producer| producer.split.last }
      .each { |producer| puts producer }

puts "\n\nКоличество фильмов, снятых не в США\n\n"
puts(movies.count { |movie| movie[:country] != 'USA' })
