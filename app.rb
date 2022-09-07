# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library_test')


# Print out each record from the result set .
repo = AlbumRepository.new
repo.all.each do |record|
  p record
end