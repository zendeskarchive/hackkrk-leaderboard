class Puzzle < ActiveRecord::Base
  has_many :guesses, :dependent => :destroy

  belongs_to :user
end

