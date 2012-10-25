class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :user_id
      t.integer :game_id
      t.float :handicap
      t.string :team
      t.boolean :result
      
      t.timestamps
    end
  end
end
