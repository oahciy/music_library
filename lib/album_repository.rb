class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;
    return SELECT * FROM Albums;
    # Returns an array of Album objects.
    # [album_1, album_2, album_3]
    # album_1 = Album.new
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