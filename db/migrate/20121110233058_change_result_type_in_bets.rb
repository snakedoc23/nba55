class ChangeResultTypeInBets < ActiveRecord::Migration
  def up
  	change_column :bets, :result, :integer
  end

  def down
  	change_column :bets, :result, :boolean
  end
end
