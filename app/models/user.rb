class User < ActiveRecord::Base
  extend Github

  def admin?
    admin
  end
end
