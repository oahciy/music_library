require 'album'

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

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;

    # Returns a single Album object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(album)
    # INSERT INTO albums (title, release_year, artist_id) VALUES ('Lover', '2019', '3');
  end

  def update(album)
    # UPDATE albums SET title = '' WHERE title = 'album';
  end

  def delete(album)
    # DELETE FROM albums WHERE title = 'album';
  end
end