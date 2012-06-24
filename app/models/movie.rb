class Movie < ActiveRecord::Base
  class Movie::InvalidKeyError < StandardError ; end

  def self.api_key
    ''
  end

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_in_tmdb keyword
    Tmdb.api_key = self.api_key
    begin
      TmdbMovie.find(:title => keyword)
    rescue ArgumentError => tmdb_error
      raise Movie::InvalidKeyError, tmdb_error.message
    rescue RuntimeError => tmdb_error
      if tmdb_error.message =~ /API returned code 404/
        raise Movie::InvalidKeyError, tmdb_error.message
      else
        raise RuntimError, tmdb_error.message
      end
    end
  end
end
