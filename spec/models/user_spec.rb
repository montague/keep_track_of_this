require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :email => "ian.asaff@gmail.com",
      :uuid => UUID.new.generate,
      :password => "password",
      :password_confirmation => "password"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  describe "uuid validation" do
    it "should require a uuid" do
      no_uuid_user = User.new(@attr.merge(:uuid => ""))
      no_uuid_user.should_not be_valid
    end

    it "should reject a duplicate uuid" do
      User.create!(@attr)
      #make email unique, otherwise it will pass due to email rejection
      dup_uuid_user = User.new(@attr.merge(:email => "test@test.com"))
      dup_uuid_user.should_not be_valid
    end
  end

  describe "email validations" do
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
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

end
