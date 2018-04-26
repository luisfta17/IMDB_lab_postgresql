require('pg')
require_relative("../db/sql_runner")
require_relative("star")
require_relative("casting")

class Movie
  attr_accessor :title, :genre, :rating
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating'].to_i
  end

  def save()
    sql = "INSERT INTO movies
    (
      title,
      genre,
      rating
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @genre, @rating]
    location = SqlRunner.run( sql, values ).first()
    @id = location['id'].to_i
  end

  def update()
  sql = "
  UPDATE movies SET (
    title,
    genre,
    artist_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    db = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    db = SqlRunner.run(sql, values)
  end


  #CLASS METHODS

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    movies_array = movies.map { |movie| Movie.new(movie)}
    return movies_array
  end

  def self.delete_all()
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)
end


end
