class Cinema
  def initialize(movie_collection)
    @movie_collection = movie_collection
  end

  def show
    showing_movie = @movie_collecion.sample

    "Now showing: #{showing_movie.title}"
  end
end
