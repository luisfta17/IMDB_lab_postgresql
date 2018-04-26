require('pg')
require_relative("../db/sql_runner")
require_relative("star")
require_relative("movie")

class Casting
  attr_accessor :movie_id, :star_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i

  end

  def save()
    sql = "INSERT INTO castings
    (
      movie_id,
      star_id

    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@movie_id, @star_id]
    castings = SqlRunner.run( sql, values ).first()
    @id = castings['id'].to_i
  end

  def update()
  sql = "
  UPDATE castings SET (
    movie_id,
    star_id
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@movie_id, @star_id, @id]
    db = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM castings WHERE id = $1"
    values = [@id]
    db = SqlRunner.run(sql, values)
  end

  # CLASS METHODS

  def self.all()
    sql = "SELECT * FROM castings"
    castings = SqlRunner.run(sql)
    castings_array = castings.map { |casting| Casting.new(casting)}
    return castings_array
  end

end
