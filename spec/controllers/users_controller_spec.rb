require 'spec_helper'

# these tests will be on the UsersController
describe UsersController do

  # before each of these tests, make a @user User instance object from Fabrication gem
  # and call Devise sign_in
  before (:each) do
    @user = Fabricate(:user)
    #sign_in is a devise method http://rubydoc.info/github/plataformatec/devise/master/Devise/Controllers/SignInOut#sign_in-instance_method
    sign_in @user
  end

  describe "GET 'show'" do

    it "should be successful" do
      # sends a GET request (I believe to show/:id)
      get :show, :id => @user.id
      # success?  checks that a process status is successful
      response.should be_success
    end


    it "should find the right user" do
      get :show, :id => @user.
      # assigns is populated after the GET request has been processed
      # checking that assigns[:user] == @user
      assigns(:user).should == @user
    end

  end

end
