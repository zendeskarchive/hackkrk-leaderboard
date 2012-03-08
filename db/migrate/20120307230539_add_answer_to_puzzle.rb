class AddAnswerToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :answer, :text
  end
end
