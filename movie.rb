require './movie_collection'
require 'date'

class Movie
  BASE_RATING = 8.0

  attr_reader :link, :title, :year, :country, :date, :genres, :length, :rating,
              :producer, :actors

  def initialize(link, title, year, country, date, genres, length, rating,
                 producer, actors, collection)
    @link = link
    @title = title
    @year = year
    @country = country
    @date = date
    @genres = genres
    @length = length
    @rating = rating
    @producer = producer
    @actors = actors
    @collection = collection
  end

  def has_genre?(genre)
    unless @collection.genres.include?(genre)
      raise ArgumentError, 'No such genre'
    end

    @genres.include?(genre)
  end

  def rating_stars
    stars_amount = (@rating * 10 - BASE_RATING * 10).to_i
    '*' * stars_amount
  end

  def to_s
    "#{@title}: (#{@date}; #{@genres.join('/')})" \
    " - #{@length} min"
  end

  def inspect
    "<Movie: object_id: #{object_id}, link: #{@link}, title: #{@title}, " \
    "year: #{@year}, country: #{@country}, date: #{@date}, " \
    "genres: [#{@genres.join(',')}], length: #{@length} min, " \
    "rating: #{@rating}, producer: #{@producer}, " \
    "actors: [#{@actors.join(',')}]>"
  end
end
