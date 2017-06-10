BASE_RATING = 8.0

file_name = ARGV[0] || 'movies.txt'

abort("File #{file_name} not found.") unless File.exist?(file_name)

File.open(file_name, 'r').each do |line|
  movie_data = line.split('|')
  name = movie_data[1]
  rating = movie_data[7].to_f

  next unless name.include?('Max')

  stars_amount = (rating * 10 - BASE_RATING * 10).to_i
  rating_stars = '*' * stars_amount
  puts "#{name} #{rating_stars}"
end
