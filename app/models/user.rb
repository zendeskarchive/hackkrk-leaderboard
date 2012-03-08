class User < ActiveRecord::Base
  has_many :guesses

  extend Github

  def admin?
    admin
  end

  def guessed?(puzzle)
    !Guess.where(:puzzle_id => puzzle.id, :user_id => self.id, :correct => true).empty?
  end

end
