class User < ActiveRecord::Base
  has_many :guesses

  class << self
    def scoresheet
      where('admin IS NOT TRUE').all.map{|user| { :name => user.username, :score => user.score }}.sort{ |a,b| b[:score] <=> a[:score] }
    end
  end

  extend Github

  attr_accessible :username, :avatar_url

  def admin?
    admin
  end

  def guessed?(puzzle)
    !Guess.where(:puzzle_id => puzzle.id, :user_id => self.id, :correct => true).empty?
  end

  def score
    Guess.where(:user_id => self.id, :correct => true).select('distinct(puzzle_id)').count
  end

  def guess_count_for_puzzle(puzzle)
    Guess.where(:puzzle_id => puzzle.id, :user_id => self.id).count
  end

end
