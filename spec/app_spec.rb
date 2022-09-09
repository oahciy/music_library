require_relative '../app'

RSpec.describe Application do
  it "runs the application and input = 1" do
    album_1 = double :album_1
    expect(album_1).to receive(:id).and_return("1")
    expect(album_1).to receive(:title).and_return("Doolittle")
    album_2 = double :album_2
    expect(album_2).to receive(:id).and_return("2")
    expect(album_2).to receive(:title).and_return("Surfer Rosa")
    album_3 = double :album_3
    expect(album_3).to receive(:id).and_return("3")
    expect(album_3).to receive(:title).and_return("Waterloo")
    album_repository = double :album_repository
    expect(album_repository).to receive(:all).and_return([album_1, album_2, album_3])

    artist_repository = double :artist_repository
    
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with("1 - List all albums\n2 - List all artists").ordered
    expect(io).to receive(:puts).with("Enter your choice: ").ordered
    expect(io).to receive(:gets).and_return("1")

    app = Application.new(
      'music_library_test',
      io,
      album_repository,
      artist_repository
    )
    app.run
  end

  it "input = 2" do
    album_repository = double :album_repository

    artist_1 = double :artist_1
    expect(artist_1).to receive(:id).and_return("1")
    expect(artist_1).to receive(:name).and_return("Pixies")
    artist_2 = double :artist_2
    expect(artist_2).to receive(:id).and_return("2")
    expect(artist_2).to receive(:name).and_return("ABBA")
    artist_repository = double :artist_repository
    expect(artist_repository).to receive(:all).and_return([artist_1, artist_2])

    io = double :io
    expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with("1 - List all albums\n2 - List all artists").ordered
    expect(io).to receive(:puts).with("Enter your choice: ").ordered
    expect(io).to receive(:gets).and_return("2")

    app = Application.new(
      'music_library_test',
      io,
      album_repository,
      artist_repository
    )
    app.run
  end

  it "neither 1 nor 2" do
    album_repository = double :album_repository
    artist_repository = double :artist_repository
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with("1 - List all albums\n2 - List all artists").ordered
    expect(io).to receive(:puts).with("Enter your choice: ").ordered
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Please Enter 1 or 2.")
    app = Application.new(
      'music_library_test',
      io,
      album_repository,
      artist_repository
    )
    app.run
  end
end