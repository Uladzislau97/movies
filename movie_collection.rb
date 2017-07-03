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
        movie.matches_filter?(k, fields[k])
      end

      result << movie
    end

    fields.reduce(@movies) do |result, field|
      result.select do |movie|
        movie.matches_filter?(field[0], field[1])
      end
    end
  end

  def stats(field)
    stats = {}
    @movies.group_by { |movie| movie.send(field.to_s) }
           .each { |k, v| stats[k] = v.count }
    stats
  end

  def genres
    @genres ||= get_genres
  end

  def to_s
    @movies.map(&:to_s).join("\n")
  end

  def inspect
    "<MovieCollection: object_id: #{object_id}, " \
    "movies: [#{@movies.map(&:inspect).join(',')}]>"
  end

  private

  def get_movies(file_name)
    CSV.read(file_name, col_sep: '|', headers: HEADERS).map do |movie_data|
      Movie.new(
        movie_data[:link],
        movie_data[:title],
        movie_data[:year],
        movie_data[:country],
        movie_data[:date],
        movie_data[:genres],
        movie_data[:length],
        movie_data[:rating],
        movie_data[:producer],
        movie_data[:actors],
        self
      )
    end
  end

  def get_genres
    @movies.reduce([]) { |genres, movie| genres + movie.genres }.uniq
  end
end
