require 'spec_helper'

describe Oauth::SessionsController do

  describe "#new" do

    it "renders a login page" do
      get :new
      response.status.should == 200
    end

  end

  describe "#destroy" do

    it "logs the user out" do
      get :destroy
      session[:user_id].should == nil
    end

  end

end
