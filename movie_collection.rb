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
    @movies = get_movies(file_name)
  end

  def all
    @movies
  end

  def sort_by(field)
    @movies.sort_by { |movie| movie.send(field.to_s) }
  end

  def filter(field)
    if field.keys.first == :genre
      @movies.select do |movie|
        movie.genres.include?(field.values.first)
      end
    elsif field.keys.first == :actors
      @movies.select do |movie|
        movie.actors.include?(field.values.first)
      end
    else
      @movies.select do |movie|
        movie.send(field.keys.first.to_s) == field.values.first
      end
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

  def get_movies(file_name)
    CSV.read(file_name, col_sep: '|', headers: HEADERS).map do |movie_data|
      Movie.new(
        movie_data[:link],
        movie_data[:title],
        movie_data[:year].to_i,
        movie_data[:country],
        string_to_date(movie_data[:date]),
        movie_data[:genres].split(','),
        movie_data[:length].to_i,
        movie_data[:rating].to_f,
        movie_data[:producer],
        movie_data[:actors].chomp.split(',')
      )
    end
  end

  def string_to_date(date)
    Date.new(*date.split('-').map(&:to_i))
  end
end
