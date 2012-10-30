class BetsController < ApplicationController

  def bet_ajax

    bets = params[:bets]
    # render json: bets['0']

    check = []
    bets.each do |bet|
      @bet = Bet.new
      @game = Game.find(bet[1][:game_id])
      @bet.user_id = current_user.id
      @bet.game_id = @game.id
      @bet.team = bet[1][:team]
      @bet.handicap = bet[1][:team] == 'a' ? @game.a_handicap : - @game.a_handicap
      if @bet.save
        check.push @bet.id
      end
    end
    render json: check
    # @bet = Bet.new
    # @game = Game.find(params[:game_id])
    # @bet.user_id = current_user.id
    # @bet.game_id = @game.id
    # @bet.team = params[:team]

    # @bet.handicap = params[:team] == 'a' ? @game.a_handicap : - @game.a_handicap
    
    # if @bet.save
    #   render json: @bet.id
    # else
    #   render json: nil
    # end

    # render json: params
  end
end
