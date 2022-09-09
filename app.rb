# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    @io.puts "Welcome to the music library manager!"
    @io.puts "What would you like to do?"
    option_1 = "1 - List all albums"
    option_2 = "2 - List all artists"
    @io.puts "#{option_1}\n#{option_2}"

    @io.puts "Enter your choice: "
    input = @io.gets.to_i
    # and then decide to run the appropriate action
    # or behaviour.
    if input == 1
      album_formatter(@album_repository.all)
      # @album_repository.all.each do |album|
      #   p "* #{album.id} - #{album.title}"
      # end
    elsif input == 2
      artist_formatter(@artist_repository.all)
      # @artist_repository.all.map do |artist|
      #   p "* #{artist.id} - #{artist.name}"
      # end
    else
      @io.puts "Please Enter 1 or 2."
    end
    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

  private

  def album_formatter(album_list)
    album_list.each do |album|
      p "* #{album.id} - #{album.title}"
    end
  end

  def artist_formatter(artist_list)
    artist_list.each do |artist|
      p "* #{artist.id} - #{artist.name}"
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end