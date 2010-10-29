# == Schema Information
# Schema version: 20101028111932
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  uuid               :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :uuid, :password, :password_confirmation

  email_regex = /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  validates :uuid,  :presence => true,
                    :uniqueness => true
                    
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 }
                        
  before_save :encrypt_password #Active Record callback
  
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  #begin class methods
  def User.authenticate(email,password)
    u = find_by_email(email)
    u && u.has_password?(password) ? u : nil
  end
  #end class methods
  private
    def encrypt_password
      if new_record? then self.salt = make_salt end
      self.encrypted_password = encrypt(self.password)
    end
    
    def encrypt(s)
      secure_hash("#{self.salt}--#{s}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{self.password}")
    end
    
    def secure_hash(s)
      Digest::SHA2.hexdigest(s)
    end
end
