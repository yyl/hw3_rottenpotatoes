require 'spec_helper'

describe Movie do
  describe 'searching TMDb by keyword' do
    it 'should call Tmdb with title keywords given valid API key' do
      TmdbMovie.should_receive(:find).with(hash_including :title => 'Inception')
      Movie.find_in_tmdb('Inception')
    end
    it 'should raise error with no API key' do
      Movie.stub(:api_key).and_return('')
      lambda {Movie.find_in_tmdb('Inception') }.
        should raise_error(Movie::InvalidKeyError)
    end
    it 'should raise error with invalid API key' do
      TmdbMovie.stub(:api_key).
        and_raise(RuntimeError.new('API returned code 404'))
      lambda {Movie.find_in_tmdb('Inception') }.
        should raise_error(Movie::InvalidKeyError)
    end
  end
end
