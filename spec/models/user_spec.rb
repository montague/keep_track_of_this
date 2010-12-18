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

  describe "admin attribute" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @user.should_not be_admin
    end
    
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe "uuid validation" do
    it "should require a uuid" do
      no_uuid_user = User.new(@attr.merge(:uuid => ""))
      no_uuid_user.should_not be_valid
    end

    it "should reject a duplicate uuid" do
      User.create!(@attr)
      #change email value, otherwise it will pass due to email rejection
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
  
  describe "password validation" do

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
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do

      it "should be true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("blahu").should be_false
      end
    end
    
    describe "authentication method" do
      it "should return nil on bad email/password combo" do
        User.authenticate(@attr[:email], "blahu").should be_nil
      end
      
      it "should return nil on bad email address" do
        User.authenticate("blahu@blahu.com", @attr[:password])
      end
      
      it "should return the user object on successful authentication" do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
    end
  end

  describe "item associations" do
    
    before(:each) do
      @user = User.create(@attr)
      @item1 = Factory(:item, :user => @user, :created_at => 1.day.ago)
      @item2 = Factory(:item, :user => @user, :created_at => 1.hour.ago)
    end
    
    it "should have an items attribute" do
      @user.should respond_to(:items)
    end
    
    it "should have the right items in the right order" do
      @user.items.should == [@item2, @item1]
    end
  end

end
