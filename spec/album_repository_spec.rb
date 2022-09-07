require "album_repository"

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table
  end

  it "returns all albums" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 3
    expect(albums[0].id).to eq '1'
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq '1989'
    expect(albums[0].artist_id).to eq '1'
    expect(albums[1].id).to eq  '2'
    expect(albums[1].title).to eq 'Surfer Rosa'
    expect(albums[1].release_year).to eq '1988'
    expect(albums[1].artist_id).to eq '1'
    expect(albums[2].id).to eq  '3'
    expect(albums[2].title).to eq 'Waterloo'
    expect(albums[2].release_year).to eq '1972'
    expect(albums[2].artist_id).to eq '2'
  end

  it "finds the album by its id" do
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.id).to eq '1'
    expect(album.title).to eq 'Doolittle'
    expect(album.release_year).to eq '1989'
    expect(album.artist_id).to eq '1'
  end

  it "creates a new album" do
    repo = AlbumRepository.new
    album = Album.new
    album.id = 4
    album.title = 'College Dropout'
    album.release_year = 2004
    album.artist_id = 3
    repo.create(album)
    albums = repo.all
    expect(albums.length).to eq 4
    expect(albums[3].id).to eq  '4'
    expect(albums[3].title).to eq 'College Dropout'
    expect(albums[3].release_year).to eq '2004'
    expect(albums[3].artist_id).to eq '3'
  end

  it "updates an album" do
    repo = AlbumRepository.new
    album = repo.all[0]
    album.release_year = 1990
    repo.update(album)
    expect(repo.find(album.id).release_year).to eq '1990'
  end
end