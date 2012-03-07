class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.text        :name
      t.text        :content
      t.timestamps
    end
  end
end
