class User < ActiveRecord::Base
  
  #has_attached_file :avatar, :styles => { :thumb => ["32x32#", :png] }  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  before_create :confirmation_token
  
  acts_as_authentic do |c|
  	 c.login_field = :username
     c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  has_many :articles
  has_many :comments
  acts_as_voter
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  #def send_password_reset
    #self.password_reset_token = SecureRandom.urlsafe_base64
    #self.password_reset_sent_at = Time.zone.now
    #save!
    #UserMailer.password_reset_instructions(@user).deliver
  #end
 
private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end


end
