class BetsController < ApplicationController

  def bet_ajax
    @bet = Bet.new
    @game = Game.find(params[:game_id])
    @bet.user_id = current_user.id
    @bet.game_id = @game.id
    @bet.team = params[:team]

    @bet.handicap = params[:team] == 'a' ? @game.a_handicap : - @game.a_handicap
    
    if @bet.save
      render json: @bet.id
    else
      render json: nil
    end
  end
end
