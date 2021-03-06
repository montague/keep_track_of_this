require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Email",            :with => "user@example.com"
          fill_in "Password",         :with => "foobar"
          fill_in "Confirm password", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
          :content => "your account has been created")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end

    describe "failure" do

      it "should not make a new user" do
        lambda do        
          visit signup_path
          fill_in "Email",            :with => ""
          fill_in "Password",         :with => ""
          fill_in "Confirm password", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
  end
  
  describe "sign in/out" do
    
    describe "failure" do
      it "should not sign a user in" do
        integration_sign_in(User.new(:email => "", :password => ""))
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

  describe "controlled navigation" do
    
    describe "signed in user" do
      it 'should be redirected to users when clicking "Home"' do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Home"
        response.should have_selector("title", :content => "Home")
      end
    end
  end
end
