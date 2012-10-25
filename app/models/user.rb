class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_many :bets
  has_secure_password
  validates_presence_of :password, :on => :create

end
