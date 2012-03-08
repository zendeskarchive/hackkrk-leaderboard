class Guess < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user

  class << self
    def validate_answer(puzzle, guess, user)
      correct = puzzle.answer == guess.to_s.strip
      self.create!(:user => user, :puzzle => puzzle, :correct => correct, :provided_answer => guess)
    end
  end
end
