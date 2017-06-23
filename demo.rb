require './movie_collection'

file_name = ARGV[0] || 'movies.csv'

abort("File #{file_name} not found.") unless File.exist?(file_name)

movies = MovieCollection.new(file_name)

puts '*' * 100
puts movies
puts '*' * 100
puts movies.sort_by(:date).first(5)
puts '*' * 100
puts movies.filter(genre: 'Comedy').first(5)
puts '*' * 100
puts movies.stats(:producer)
puts '*' * 100
puts movies.all.first.inspect
puts '*' * 100
puts movies.inspect
puts '*' * 100
puts movies.all.first.inspect
puts '*' * 100
puts movies.all.first.has_genre?('Comedy')
puts '*' * 100

begin
  movies.all.first.has_genre?('Tradegy')
rescue ArgumentError => e
  puts e.message
end
