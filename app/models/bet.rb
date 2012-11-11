class Bet < ActiveRecord::Base
  attr_accessible :game_id, :handicap, :result, :team, :user_id

  belongs_to :user
  belongs_to :game


  def update_result
    if game.h_score && result.nil?
      if team == 'a'
        score = game.a_score + handicap - game.h_score
      else
        score = game.h_score + handicap - game.a_score
      end

      if score > 0
        self.result = 1
      elsif score < 0
        self.result = -1
      else
        self.result = 0
      end
      save
    end
  end
end
