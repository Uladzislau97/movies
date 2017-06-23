require 'date'
require 'csv'
require 'ostruct'

BASE_RATING = 8.0

file_name = ARGV[0] || 'movies.csv'

abort("File #{file_name} not found.") unless File.exist?(file_name)

def rating_stars(rating)
  stars_amount = (rating * 10 - BASE_RATING * 10).to_i
  '*' * stars_amount
end

def string_to_date(date)
  Date.new(*date.split('-').map(&:to_i))
end

def movie_format(movie)
  "#{movie.title}: (#{movie.date}; #{movie.genres.join('/')})" \
  " - #{movie.length} min"
end

headers = %I[
  link
  title
  year
  country
  date
  genres
  length
  rating
  producer
  actors
]

movies = CSV.read(file_name, col_sep: '|', headers: headers).map do |movie_data|
  OpenStruct.new(
    link: movie_data[:link],
    title: movie_data[:title],
    year: movie_data[:year].to_i,
    country: movie_data[:country],
    date: string_to_date(movie_data[:date]),
    genres: movie_data[:genres].split(','),
    length: movie_data[:length].to_i,
    rating: movie_data[:rating].to_f,
    producer: movie_data[:producer],
    actors: movie_data[:actors].chomp.split(',')
  )
end

puts "\n\n5 самых длинных фильмов\n\n"
movies.sort_by(&:length)
      .reverse
      .take(5)
      .each { |movie| puts movie_format(movie) }

puts "\n\n10 комедий\n\n"
movies.select { |movie| movie.genres.include?('Comedy') }
      .sort_by(&:date)
      .take(10)
      .each { |movie| puts movie_format(movie) }

puts "\n\nСписок всех режиссёров\n\n"
movies.map(&:producer)
      .uniq
      .sort_by { |producer| producer.split.last }
      .each { |producer| puts producer }

puts "\n\nКоличество фильмов, снятых не в США\n\n"
puts(movies.count { |movie| movie.country != 'USA' })

puts "\n\nКоличество фильмов по месяцам\n\n"
movies.map(&:date)
      .group_by(&:month)
      .sort_by(&:first)
      .to_a
      .each do |month, group|
        puts "#{Date::MONTHNAMES[month]}: #{group.count}"
      end
