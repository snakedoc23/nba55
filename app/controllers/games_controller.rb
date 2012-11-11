class GamesController < ApplicationController
  require 'open-uri'
  before_filter :authenticate
  
  def index
    @date = Date.today.to_time
    @bets = Bet.where(user_id: current_user.id).where("created_at > '#{@date.beginning_of_day}' AND created_at < '#{@date.end_of_day}'")
  
    @bets_other = Bet.where("user_id != '#{current_user.id}'").where("created_at > '#{@date.beginning_of_day}' AND created_at < '#{@date.end_of_day}'")
    @users = User.all

    @games = Game.today
    if @games.empty?
      Game.fetch_next_games
      Game.update_scores

    end

    @bet = Bet.new
  end

  def update_lines
    Game.update_lines
    redirect_to :action => "index"
  end


  def day
    @date = params[:date].to_date
    if @date  == Date.today.to_date
      redirect_to :action => index
    end

    @users = User.all

    @games = Game.where(:date => @date)
    @prev_day = @date.yesterday.strftime("%Y%m%d")
    @next_day = @date.next_day.strftime("%Y%m%d")

    @bets = Bet.where(user_id: current_user.id).where("created_at > '#{@date.beginning_of_day}' AND created_at < '#{@date.end_of_day}'")
  
    @bets_other = Bet.where("user_id != '#{current_user.id}'").where("created_at > '#{@date.beginning_of_day}' AND created_at < '#{@date.end_of_day}'")


    # @overs = Game.day_o_u(params[:date])[:o]
    # @unders = Game.day_o_u(params[:date])[:u]
    # @bets = Game.system_bet(params[:date])
  end



end
