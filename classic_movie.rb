require './movie'

class ClassicMovie < Movie
  def initialize(link, title, year, country, date, genres, length, rating,
                 producer, actors, collection)
    super(link, title, year, country, date, genres, length, rating,
          producer, actors, collection, 1.5)
  end

  def to_s
    other_movies = @collection.select { |m| m.producer == @producer }
                              .take(10)
                              .map(&:title)

    "#{@title} - классический фильм, режиссер: #{@producer}" \
    "(#{other_movies.join(', ')})."
  end
end
