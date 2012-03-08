class AddUserIdToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :user_id, :integer
  end
end
