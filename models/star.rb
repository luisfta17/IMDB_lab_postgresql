require('pg')
require_relative("../db/sql_runner")
require_relative("movie")
require_relative("casting")

class Star
  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO stars
    (
      first_name,
      last_name
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run( sql, values ).first()
    @id = star['id'].to_i
  end

  def update()
  sql = "
  UPDATE stars SET (
    first_name,
    last_name
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    db = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    db = SqlRunner.run(sql, values)
  end


  # Class Methods
  def self.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql)
    stars_array = stars.map { |star| Star.new(star)}
    return stars_array
  end
end
