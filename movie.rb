require 'date'

class Movie
  BASE_RATING = 8.0

  attr_reader :link, :title, :year, :country, :date, :genres, :length, :rating,
              :producer, :actors

  @@genres = []

  def initialize(link, title, year, country, date, genres, length, rating, producer, actors)
    @link = link
    @title = title
    @year = year
    @country = country
    @date = date
    @genres = genres
    @@genres += genres
    @@genres.uniq!
    @length = length
    @rating = rating
    @producer = producer
    @actors = actors
  end

  def has_genre?(genre)
    raise ArgumentError, 'No such genre' unless @@genres.include?(genre)

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
