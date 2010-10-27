# == Schema Information
# Schema version: 20101027162922
#
# Table name: users
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :email, :uuid

  email_regex = /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  validates :uuid,  :presence => true,
                    :uniqueness => true
end
