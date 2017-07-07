require './movie'

class ModernMovie < Movie
  def initialize(link, title, year, country, date, genres, length, rating,
                 producer, actors, collection)
    super(link, title, year, country, date, genres, length, rating,
          producer, actors, collection, 3.0)
  end

  def to_s
    "#{@title} - современное кино, играют: #{@actors.join(', ')}."
  end
end
