require './movie'

class NewMovie < Movie
  def initialize(link, title, year, country, date, genres, length, rating,
                 producer, actors, collection)
    super(link, title, year, country, date, genres, length, rating,
          producer, actors, collection, 5.0)
  end

  def to_s
    "#{@title} - новинка, вышло #{Date.today.year - @year} лет назад!"
  end
end
