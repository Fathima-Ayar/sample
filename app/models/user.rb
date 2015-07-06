class User < ActiveRecord::Base

  attr_accessible :role
  acts_as_authentic do |c|
     c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  has_many :articles
  has_many :comments
  acts_as_voter

end
