class Oauth::TwitterController < ApplicationController
  REDIRECT_URI = '/oauth/twitter/callback'

  skip_before_filter :authenticate_user

  def new
    consumer = User::Twitter.client
    request_token = consumer.get_request_token(:oauth_callback => User::Twitter.redirect_uri(request))
    session[:request_token] = request_token
    redirect_to request_token.authorize_url
  end

  def create
    @request_token = session[:request_token]
    token = @request_token.get_access_token

    if token
      access_token = "#{token.token}:#{token.secret}"
      if user = User.find_by_access_token(access_token)
        session[:user_id] = user.id
        redirect_to '/'
      elsif user = User::Twitter.create_user(token, access_token)
        session[:user_id] = user.id
        redirect_to '/'
      end

    else
      redirect_to '/login', :error => 'Could not log you in, please try again'
    end

  end

end
