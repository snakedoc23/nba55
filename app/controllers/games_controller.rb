class GamesController < ApplicationController

  before_filter :authenticate
  
  def index
  	@games = Game.today
  	@bet = Bet.new
  end
end
