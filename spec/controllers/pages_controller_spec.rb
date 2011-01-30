require 'spec_helper'

describe PagesController do
  render_views

  def title(t)
    "KeepTrackOfThis.com | #{t}"
  end

  describe "GET 'home'" do
      
      describe "for non-signed-in users" do
        it "should redirect to signin" do
          get 'home'
          response.should redirect_to signin_path
        end
      end
      
      describe "for signed-in users" do
        it "should be successful" do
          test_sign_in(Factory(:user))
          get 'home'
          response.should be_success
        end
      end
    end
  
  describe "GET 'bookmarklet'" do
    
    describe "for non-signed-in users" do
      it "should redirect to signin" do
        get 'bookmarklet'
        response.should redirect_to signin_path
      end
    end
    
    # describe "for signed-in users" do
    #       test_sign_in(Factory(:user))
    #       it "should be successful" do
    #         get 'bookmarklet'
    #         response.should be_success
    #       end
    #     end
  end
  

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
