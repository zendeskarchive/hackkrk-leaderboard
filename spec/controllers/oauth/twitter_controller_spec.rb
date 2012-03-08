require 'spec_helper'

describe Oauth::TwitterController do

  before do
    @client = mock
  end

  describe '#new' do

    it "redirects to twitter" do
      User::Twitter.should_receive(:client).and_return(@client)
      token = mock(:authorize_url => 'http://twitter.com/authme')
      @client.
        should_receive(:get_request_token).
        with(:oauth_callback => "http://test.host/oauth/twitter/callback").
        and_return(token)
      get :new
      response.should redirect_to('http://twitter.com/authme')
    end

  end

  describe "#create" do

    before do
      @token = mock
      @token.stub!(:token).and_return('TOKKKK')
      @token.stub!(:secret).and_return('SECRETTTT')
      @request_token = mock
      session[:request_token] = @request_token
    end

    it "authorizes, creates, and log ins the user if not present" do
      @request_token.should_receive(:get_access_token).and_return(@token)

      user = mock(:id => 42)
      User::Twitter.
        should_receive(:create_user).
        with(@token, 'TOKKKK:SECRETTTT').
        and_return(user)

      get :create, :code => 'AAA'

      session[:user_id].should == 42

      response.should redirect_to('/')
    end

    it "authorizes and log ins the user if present" do
      @request_token.should_receive(:get_access_token).and_return(@token)

      user = mock(:id => 42)
      User.
        should_receive(:find_by_access_token).
        with('TOKKKK:SECRETTTT').
        and_return(user)

      User::Twitter.
        should_not_receive(:create_user)


      get :create, :code => 'AAA'

      session[:user_id].should == 42

      response.should redirect_to('/')
    end

    it "redirects to login on auth error" do
      @request_token.should_receive(:get_access_token).and_return(nil)

      get :create, :code => 'AAA'

      session[:user_id].should == nil

      response.should redirect_to('/login')

    end

  end

end
