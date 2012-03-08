class Puzzle < ActiveRecord::Base
  has_many :guesses, :dependent => :destroy
end

