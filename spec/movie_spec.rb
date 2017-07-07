require './movie'
require 'rspec'

RSpec.describe Movie do
  let(:movie) do
    MovieCollection.new('movies.csv').all.first
  end

  describe '#has_genre?' do
    context 'when movie has a genre' do
      it 'returns true' do
        expect(movie.has_genre?('Crime')).to be true
      end
    end

    context "when movie hasn't got a genre" do
      it 'returns false' do
        expect(movie.has_genre?('Comedy')).to be false
      end
    end

    context "when collection hasn't got a genre" do
      it 'raises an exception' do
        expect do
          movie.has_genre?('Tradegy')
        end.to raise_error(ArgumentError, 'No such genre')
      end
    end
  end

  describe '#matches_filter?' do
    context 'when movie matches filter' do
      it 'returns true' do
        expect(movie.matches_filter?(:year, 1994)).to be true
      end
    end

    context "when movie doesn't matches filter" do
      it 'returns false' do
        expect(movie.matches_filter?(:country, 'Canada')).to be false
      end
    end

    context "when correct regex is passed" do
      it 'returns true' do
        expect(movie.matches_filter?(:title, /Shawshank/i)).to be true
      end
    end

    context "when correct range of years is passed" do
      it 'returns true' do
        expect(movie.matches_filter?(:year, 1993..1995)).to be true
      end
    end
  end
end
