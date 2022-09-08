require_relative 'album'

class AlbumRepository

  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])

    albums = []
    result.each do |record|
      album = Album.new
      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      album.artist_id = record["artist_id"]
      albums << album
    end
    return albums
  end

  def find(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    para = [id]
    result = DatabaseConnection.exec_params(sql, para)
    record = result[0]

    album = Album.new
    album.id = record["id"]
    album.title = record["title"]
    album.release_year = record["release_year"]
    album.artist_id = record["artist_id"]
    return album
  end

  def create(album)
    # INSERT INTO albums (title, release_year, artist_id) VALUES ('Lover', '2019', '3');
    sql = "INSERT INTO albums (id, title, release_year, artist_id) VALUES 
    (#{album.id},'#{album.title}', #{album.release_year}, #{album.artist_id});"
    result = DatabaseConnection.exec_params(sql, [])
  end

  def update(album)
    # UPDATE albums SET title = '' WHERE title = 'album';
    sql = "UPDATE albums SET title = '#{album.title}', release_year = #{album.release_year}, artist_id = #{album.artist_id} WHERE id = #{album.id};"
    result = DatabaseConnection.exec_params(sql, [])
  end

  def delete(album)
    sql = "DELETE FROM albums WHERE id = #{album.id};"
    result = DatabaseConnection.exec_params(sql, [])
  end

  def update_by(album, attr)
    attr_sym = attr.to_sym
    sql = "UPDATE albums SET #{attr} = #{album.send(attr_sym)};"
    # https://www.notonlycode.org/12-ways-to-call-a-method-in-ruby/
    result = DatabaseConnection.exec_params(sql, [])
  end
end