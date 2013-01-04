class Bet < ActiveRecord::Base
  attr_accessible :game_id, :handicap, :result, :team, :user_id

  after_save :send_mail

  belongs_to :user
  belongs_to :game

  def self.update_results
    self.all.each {|b| b.update_result}
  end

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

  def send_mail
    user_id = 3

    print '==================='
    # if check_other_bets(user_id)
      bets = today_bets(user_id)
      email = User.find(user_id).email
      BetMailer.bets(email, bets).deliver
    # end
  end

  def check_other_bets(user_id)
    bets = today_bets(user_id)
    !bets.other.empty?
  end

  def today_bets(user_id)
    @date = Date.today.to_time
    bets_user = Bet.where(user_id: user_id).where("created_at > '#{@date.beginning_of_day}' AND created_at < '#{@date.end_of_day}'")
    bets_other = Bet.where("user_id != '#{user_id}'").where("created_at > '#{@date.beginning_of_day}' AND created_at < '#{@date.end_of_day}'")
    bets = {}
    bets[:user] = bets_user
    bets[:other] = bets_other
    bets
  end
end
