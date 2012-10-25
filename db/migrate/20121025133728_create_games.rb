class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :a_team
      t.string :h_team
      t.date :date
      t.time :time
      t.integer :a_score
      t.integer :h_score
      t.float :a_handicap

      t.timestamps
    end
  end
end
