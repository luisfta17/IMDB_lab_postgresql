require_relative( './models/movie' )
require_relative( './models/star' )
require_relative( './models/casting' )

require( 'pry' )

movie1 = Movie.new({ 'title' => 'The last Jedi', 'genre' => 'Space opera', 'rating' => '5' })
movie1.save()
star1 = Star.new({ 'first_name' => 'Mark', 'last_name' => 'Hammil'})
star2 = Star.new({ 'first_name' => 'Chew', 'last_name' => 'Bacca'})
star2.save()
casting2= Casting.new({ 'movie_id' => movie1.id, 'star_id' => star2.id})
casting2.save()


binding.pry
nil
