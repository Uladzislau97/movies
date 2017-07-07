require './cinema'

class Netflix < Cinema
  def initialize(movie_collection)
    super(movie_collection)
    @count = 0
  end

  def show(options = {})
  end

  def pay(sum)
    @count += sum if sum > 0
  end
end
