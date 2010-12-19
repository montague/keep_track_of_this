require 'spec_helper'

describe Tag do
  
  before(:each) do
    @user = Factory(:user)
    @item = Factory(:item, :user => @user)
    @attr = { :name => "test tag" }
  end
  
  it "should actually work" do
    pending "skipping tags until i know wtf i'm doing..."
  end
  
  it "should create a new Tag given valid attributes" do  
    Tag.create!(@attr)
  end
  
  describe "validations" do
    
    it "should fail if name is blank" do
      Tag.create(:name => "  ").should_not be_valid
    end
    
    it "should be associated with at least one item" do
      pending "should be associated with at least one item... no idea how to do this."
    end
    
    it "shouldn't be able to be deleted unless there are no associated items" do
      pending "shouldn't be able to be deleted unless there are no associated items"
    end
    
    
  end
  
end
