class User < ActiveRecord::Base
  has_many :guesses

  class << self
    def scoresheet
      all.map{|user| { :name => user.username, :score => user.score }}.sort{ |a,b| b[:score] <=> a[:score] }
    end
  end

  extend Github

  def admin?
    admin
  end

  def guessed?(puzzle)
    !Guess.where(:puzzle_id => puzzle.id, :user_id => self.id, :correct => true).empty?
  end

  def score
    Guess.where(:user_id => self.id, :correct => true).select('distinct(puzzle_id)').count
  end
end
