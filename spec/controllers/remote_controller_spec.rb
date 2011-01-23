require 'spec_helper'

describe RemoteController do
  before(:each) do
    @user = Factory(:user)
    @attr = {:u => @user.uuid, :s => "test_subject", :c => "test_content"}
  end
  describe "'GET' create" do
    it "should be successful" do
      get :create
      response.should be_success
    end
    
    it "should create a new item if valid querystring params" do
      lambda do
        get :create, @attr
      end.should change(@user.items, :count).by(1)    end
  end
end
