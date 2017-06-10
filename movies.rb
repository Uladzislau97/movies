good_movies = ['Matrix']
bad_movies = ['Titanic']

if ARGV.any?
  movie = ARGV[0]

  if good_movies.include?(movie)
    puts "#{movie} is a good movie"
  elsif bad_movies.include?(movie)
    puts "#{movie} is a bad movie"
  else
    puts "Haven't seen #{movie} yet"
  end
end
