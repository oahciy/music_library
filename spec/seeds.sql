TRUNCATE TABLE albums RESTART IDENTITY;
TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO albums (title, release_year, artist_id) VALUES 
  ('Doolittle', 1989, 1),
  ('Surfer Rosa', 1988, 1),
  ('Waterloo', 1972, 2);

INSERT INTO artists (name, genre) VALUES 
  ('Pixies', 'Rock'),
  ('ABBA', 'Pop');