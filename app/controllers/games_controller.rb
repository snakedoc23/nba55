class GamesController < ApplicationController

  before_filter :authenticate
  
  def index
  	@games = Game.all
  	@bet = Bet.new
  end
end
