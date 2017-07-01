require './movie'
require 'csv'

class MovieCollection
  HEADERS = %I[
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
  ].freeze

  attr_reader :genres

  def initialize(file_name)
    @genres = []
    @movies = get_movies(file_name)
  end

  def all
    @movies
  end

  def sort_by(field)
    @movies.sort_by(&field)
  end

  def filter(fields)
    @movies.reduce([]) do |result, movie|
      next result unless fields.keys.all? do |k|
        matches_filter?(movie, k, fields[k])
      end

      result << movie
    end
  end

  def stats(field)
    stats = {}
    @movies.group_by { |movie| movie.send(field.to_s) }
           .each { |k, v| stats[k] = v.count }
    stats
  end

  def to_s
    @movies.map(&:to_s).join("\n")
  end

  def inspect
    "<MovieCollection: object_id: #{object_id}, " \
    "movies: [#{@movies.map(&:inspect).join(',')}]>"
  end

  private

  def matches_filter?(movie, field, value)
    if movie.respond_to?(field)
      value === movie.send(field.to_s)
    else
      movie.send("#{field}s").include?(value)
    end
  end

  def get_movies(file_name)
    CSV.read(file_name, col_sep: '|', headers: HEADERS).map do |movie_data|
      genres = movie_data[:genres].split(',')
      @genres += genres
      @genres.uniq!

      Movie.new(
        movie_data[:link],
        movie_data[:title],
        movie_data[:year].to_i,
        movie_data[:country],
        string_to_date(movie_data[:date]),
        genres,
        movie_data[:length].to_i,
        movie_data[:rating].to_f,
        movie_data[:producer],
        movie_data[:actors].chomp.split(','),
        self
      )
    end
  end

  def string_to_date(date)
    Date.new(*date.split('-').map(&:to_i))
  end
end
