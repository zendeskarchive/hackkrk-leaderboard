class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :user_id
      t.integer :puzzle_id
      t.boolean :correct
      t.text :provided_answer

      t.timestamps
    end
  end
end
