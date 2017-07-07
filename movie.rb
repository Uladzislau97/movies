require './movie_collection'
require 'date'

class Movie
  BASE_RATING = 8.0

  attr_reader :link, :title, :year, :country, :date, :genres, :length, :rating,
              :producer, :actors, :price

  def initialize(link, title, year, country, date, genres, length, rating,
                 producer, actors, collection, price = 0)
    @link = link
    @title = title
    @year = year.to_i
    @country = country
    @date = string_to_date(date)
    @genres = genres.split(',')
    @length = length.to_i
    @rating = rating.to_f
    @producer = producer
    @actors = actors.chomp.split(',')
    @collection = collection
    @price = price
  end

  def has_genre?(genre)
    unless @collection.genres.include?(genre)
      raise ArgumentError, 'No such genre'
    end

    @genres.include?(genre)
  end

  def matches_filter?(field, value)
    if respond_to?(field)
      value === send(field.to_s)
    else
      send("#{field}s").include?(value)
    end
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

  private

  def string_to_date(date)
    Date.new(*date.split('-').map(&:to_i))
  end
end
