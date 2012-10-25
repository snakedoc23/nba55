class GamesController < ApplicationController

  before_filter :authenticate
  
  def index
  	@games = Game.today
  end
end
