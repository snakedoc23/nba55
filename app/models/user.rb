class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_many :bets
  has_secure_password
  validates_presence_of :password, :on => :create


  def bet_score(day = nil)

    day = day || Date.yesterday.strftime("%Y%m%d")

  	score = 0
  	b_plus = 0
  	b_count = 0
    b_count_d = 0
  	bets.where("created_at < '#{day.to_date.end_of_day}'").each do |b|
  		score += b.result
  		if b.result == 1
  			b_plus += 1
  		end
  		b_count += 1
      if b.result != 0
        b_count_d += 1
      end

  	end
  	score
  	"#{b_plus} / #{b_count} (#{b_count_d} - #{(b_plus.to_f / b_count_d * 100).to_i}%)"
  end

end
