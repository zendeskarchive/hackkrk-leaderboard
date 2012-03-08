class User < ActiveRecord::Base
  extend Github

  attr_accessible :username, :avatar_url

end
