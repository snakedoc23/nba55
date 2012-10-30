class GamesController < ApplicationController
  require 'open-uri'
  before_filter :authenticate
  
  def index
    @date = Date.today.to_time
    @bets = Bet.where(user_id: current_user.id).where("updated_at > '#{@date.beginning_of_day}' AND updated_at < '#{@date.end_of_day}'")
  	@games = Game.today
    if @games.empty?
      Game.fetch_next_games
    end

  	@bet = Bet.new
  end

  def update_lines
    Game.update_lines
    redirect_to :action => "index"
  end


end
