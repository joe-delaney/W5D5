def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .joins(:actors)
    .select('movies.id,movies.title')
    .where('actors.name IN (?)', those_actors)
    .group('movies.id')
    .having('count(*)=?',those_actors.length)

end

def golden_age
  # Find the decade with the highest average movie score.

  Movie
      .select('((yr / 10) * 10) AS decade')
      .group('decade')
      .order('avg(score) DESC')
      .limit(1)
      .first
      .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery

  movies = Movie.joins(:actors).select('movies.title').where('actors.name = (?)',name)

  movies_titles = movies.map{|movie| movie.title}

  actors = Actor
    .joins(:movies)
    .select('actors.name')
    .where('movies.title in (?)', movies_titles)
    .where.not('actors.name = (?)', name)
    .distinct

  actors.map{|actor| actor.name}

  # Actor.joins(:movies).where("actors.name = (?)", 'Matt Damon').select('movies.title')

  # Movie.joins('join actors AS name_actors ON castings.actor_id = actors.id').joins('join actors AS all_actors ON castings.actor_id = actors.id').select('all_actors.name').where('name_actors.name = (?)',name)


end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_outer_joins(:movies)
    .where('castings.id IS NULL')
    .count

end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

  new_str = "%"
  whazzername.each_char {|char| new_str += "#{char}%"}

  Movie
    .joins(:actors)
    .select('movies.*,actors.name')
    .where('actors.name ILIKE (?)', new_str)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
    .joins(:movies)
    .select('actors.id, actors.name, (MAX(movies.yr) - MIN(movies.yr)) AS career')
    .group('actors.id')
    .order('career DESC')
    .limit(3)
end
