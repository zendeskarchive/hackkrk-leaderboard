require 'spec_helper'

describe Oauth::GithubController do

  before do
    @client = mock
    User::Github.
      stub_chain(:client, :auth_code).
      and_return(@client)
  end
  describe '#new' do

    it "redirects to github" do
      @client.
        should_receive(:authorize_url).
        with(:redirect_uri => "http://test.host/oauth/github/callback").
        and_return('http://github.com/api')
      get :new
      response.should redirect_to('http://github.com/api')
    end

  end

  describe "#create" do

    it "authorizes, creates, and log ins the user if not present" do
      token = mock

      token.stub_chain(:client, :site=)
      token.should_receive(:token).and_return 'OMG'

      @client.should_receive(:get_token).with("AAA", {
        :redirect_uri=>"http://test.host/oauth/github/callback"
      }).and_return(token)

      user = mock(:id => 42)
      User::Github.
        should_receive(:create_user).
        with(token).
        and_return(user)

      get :create, :code => 'AAA'

      session[:user_id].should == 42

      response.should redirect_to('/')
    end

    it "authorizes and log ins the user if present" do
      token = mock

      token.stub_chain(:client, :site=)
      token.should_receive(:token).and_return 'OMG'

      @client.should_receive(:get_token).with("AAA", {
        :redirect_uri=>"http://test.host/oauth/github/callback"
      }).and_return(token)

      user = mock(:id => 42)
      User.
        should_receive(:find_by_access_token).
        with('OMG').
        and_return(user)

      User::Github.
        should_not_receive(:create_user)

      get :create, :code => 'AAA'

      session[:user_id].should == 42

      response.should redirect_to('/')

    end

    it "redirects to login on auth error" do
      client = mock

      client.should_receive(:get_token).with("AAA", {
        :redirect_uri=>"http://test.host/oauth/github/callback"
      }).and_return(nil)

      User::Github.
        stub_chain(:client, :auth_code).
        and_return(client)

      get :create, :code => 'AAA'

      session[:user_id].should == nil

      response.should redirect_to('/login')

    end

  end

end
