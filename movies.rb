BASE_RATING = 8.0

if ARGV.any?
  file_name = ARGV[0]
else
  file_name = 'movies.txt'
  puts "Warning! File name wasn't passed. Movies.txt is used by default.\n\n"
end

File.open(file_name, 'r').each do |line|
  movie_data = line.split('|')
  name = movie_data[1]
  rating = movie_data[7].to_f

  next unless name.include?('Max')

  stars_amount = (rating * 10 - BASE_RATING * 10).to_i
  rating_stars = '*' * stars_amount
  puts "#{name} #{rating_stars}"
end
