class Game < ActiveRecord::Base
  attr_accessible :a_score, :a_team, :date, :h_score, :h_team, :handicap_h

  has_many :bets

  scope :today, where(date: Date.today)
  # scope :today, where(date: '20121025'.to_date)


  def self.update_scores(day = nil)
    day = day || Date.yesterday.strftime("%Y%m%d")
    url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
    doc = Nokogiri::HTML(open(url))
    doc.css("table.tbl-odds").each do |game|
      g = Game.where(:date => "#{day}".to_date).where(:h_team => game.css(".tbl-odds-c2").last.text).first
      if g
        g.a_score = game.css(".tbl-odds-c3").first.text.to_i
        g.h_score = game.css(".tbl-odds-c3").last.text.to_i
        g.save
      else
        p "No games to update in db"
      end
    end
    # update results for all bets
  end

  def self.update_lines(day = nil)
    day = day || Date.today.strftime("%Y%m%d")
    url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
    doc = Nokogiri::HTML(open(url))
    doc.css("table.tbl-odds").each do |game|
      g = Game.where(:date => "#{day}".to_date).where(:h_team => game.css(".tbl-odds-c2").last.text).first
      g.a_handicap = game.at_css(".tbl-odds-c5").text.gsub("\u00BD", ".5")[0,5].to_f
      g.save
    end
  end

  def self.fetch_next_games(day = nil)
    day = day || Date.today.strftime("%Y%m%d")
    url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
    doc = Nokogiri::HTML(open(url))
    doc.css("table.tbl-odds").each do |game|
      g = Game.create!
      g.time = Time.parse(game.css(".tbl-odds-time").text.split.first) if game.css(".tbl-odds-time").first.text.split.size > 1
      g.date = "#{day}".to_date
      g.a_team = game.css(".tbl-odds-c2").first.text
      g.h_team = game.css(".tbl-odds-c2").last.text
      # g.a_score = game.css(".tbl-odds-c3").first.text.to_i
      # g.h_score = game.css(".tbl-odds-c3").last.text.to_i
      g.a_handicap = game.at_css(".tbl-odds-c5").text.gsub("\u00BD", ".5")[0,5].to_f
      g.save
    end
  end

end
