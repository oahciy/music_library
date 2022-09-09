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

  def find_with_albums(id)
    sql = 'SELECT artists.id,
                  artists.name,
                  artists.genre,
                  albums.id AS album_id,
                  albums.title,
                  albums.release_year
          FROM artists
          JOIN albums ON albums.artist_id = artists.id
          WHERE artists.id = $1;'

    para = [id]
    result = DatabaseConnection.exec_params(sql, para)

    artist = Artist.new
    artist.id = result.first['id']
    artist.name = result.first['name']
    artist.genre = result.first['genre']

    result.each do |record|
      album = Album.new
      album.id = record['album_id']
      album.title = record['title']
      album.release_year = record['release_year']

      artist.albums << album
    end

    return artist
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