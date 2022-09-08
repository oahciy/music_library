require_relative 'album'

class AlbumRepository

  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])

    albums = []
    result.each do |record|
      albums << record_to_album(record)
    end
    return albums
  end

  def find(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    para = [id]
    result = DatabaseConnection.exec_params(sql, para)
    record = result[0]

    record_to_album(record)
  end

  def create(album)
    sql = "INSERT INTO albums (title, release_year, artist_id) VALUES 
    ($1, $2, $3);"
    para = [album.title, album.release_year, album.artist_id]
    result = DatabaseConnection.exec_params(sql, para)
    return nil
  end

  def update(album)
    sql = "UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;"
    para = [album.title, album.release_year, album.artist_id, album.id]
    result = DatabaseConnection.exec_params(sql, para)
    return nil
  end

  def delete(album)
    sql = "DELETE FROM albums WHERE id = $1;"
    para = [album.id]
    result = DatabaseConnection.exec_params(sql, para)
    return nil
  end

  def update_by(album, attr)
    attr_sym = attr.to_sym
    sql = "UPDATE albums SET #{attr} = $1 WHERE id = $2;"
    # https://www.notonlycode.org/12-ways-to-call-a-method-in-ruby/
    para = [album.send(attr_sym), album.id]
    result = DatabaseConnection.exec_params(sql, para)
    return nil
  end

  private
  
  def record_to_album(record)
    album = Album.new
    album.id = record["id"].to_i
    album.title = record["title"]
    album.release_year = record["release_year"].to_i
    album.artist_id = record["artist_id"].to_i
    return album
  end
end