class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  
  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /^((?:(?:(?:[a-z0-9][\.\-\+_]?)*)[a-zA-Z0-9])+)\@((?:(?:(?:[a-z0-9][\.\-_]?){0,62})[a-z0-9])+)\.([a-z0-9]{2,6})$/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensative: false }
                      
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end