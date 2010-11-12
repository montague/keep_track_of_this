require 'spec_helper'

describe PagesController do
  render_views

  def title(t)
    "KeepTrackOfThis.com | #{t}"
  end

  # describe "GET 'home'" do
  #     it "should be successful" do
  #       get 'home'
  #       response.should be_success
  #     end
  #     
  #     it "should have the right title" do
  #       get 'home'
  #       response.should have_selector("title", :content => title("Sign up"))
  #     end
  #   end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => title("Contact"))
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title", :content => "KeepTrackOfThis.com | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", :content => "KeepTrackOfThis.com | Help")
    end
  end

end
