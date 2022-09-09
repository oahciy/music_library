require_relative 'artist'

class ArtistRepository
  def all
    sql = 'SELECT * FROM artists;'
    result = DatabaseConnection.exec_params(sql, [])

    artists = []
    result.each do |record|
      artists << record_to_artist(record)
    end
    return artists
  end

  private
  
  def record_to_artist(record)
    artist = Artist.new
    artist.id = record["id"].to_i
    artist.name = record["name"]
    artist.genre = record["genre"]
    return artist
  end
end