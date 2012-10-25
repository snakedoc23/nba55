class Game < ActiveRecord::Base
  attr_accessible :a_score, :a_team, :date, :h_score, :h_team, :handicap_h

  scope :today, where(date: Date.today)
end
