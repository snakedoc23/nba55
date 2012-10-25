class Bet < ActiveRecord::Base
  attr_accessible :game_id, :handicap, :result, :team, :user_id

  belongs_to :user
  belongs_to :game

end
