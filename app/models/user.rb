class User < ActiveRecord::Base
  acts_as_authentic do |c|
     c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  has_many :articles
  has_many :comments
  acts_as_voter
end
