require './movie'

class AncientMovie < Movie
  def initialize(link, title, year, country, date, genres, length, rating,
                 producer, actors, collection)
    super(link, title, year, country, date, genres, length, rating,
          producer, actors, collection, 1.0)
  end

  def to_s
    "#{@title} - старый фильм (#{@year} год)."
  end
end
