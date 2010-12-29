require 'spec_helper'

describe Item do
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content", :subject => "value for subject" }
  end
  
  it "should create a new instance given valid attribtues" do
    @user.items.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @item = @user.items.create(@attr)
    end
    
    it "should have a user attribute" do
      @item.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @item.user_id.should == @user.id
      @item.user.should == @user
    end
  end
  
  describe "validations" do
    
    it "should require a user id" do
      Item.new(@attr).should_not be_valid
    end
    
    it "should require nonblank content" do
      @user.items.build(:content => "  ").should_not be_valid
    end
    
    it "should require nonblank subject" do
      @user.items.build(:subject => "  ").should_not be_valid
    end
  end
end
