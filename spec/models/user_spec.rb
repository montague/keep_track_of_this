require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:email => "ian.asaff@gmail.com"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    %w[user@foo,com THE_USER_at_foo.bar.org first.last@foo.].each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end    
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    dup = User.new(@attr)
    dup.should_not be_valid
  end
  
  it "should reject duplicate emails regardless of case" do
    User.create!(@attr)
    dup = User.new(@attr.merge(:email => @attr[:email].upcase))
    dup.should_not be_valid
  end
end
