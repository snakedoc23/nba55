class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_many :bets
  has_secure_password
  validates_presence_of :password, :on => :create


  def bet_score
  	score = 0
  	b_plus = 0
  	b_count = bets.count
  	bets.each do |b|
  		score += b.result
  		if b.result == 1
  			b_plus += 1
  		end
  		# b_count += 1
  	end
  	score
  	"#{b_plus} / #{b_count}"
  end

end
