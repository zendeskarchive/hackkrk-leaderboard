class Oauth::GithubController < ApplicationController
  REDIRECT_URI = '/oauth/github/callback'

  skip_before_filter :authenticate_user

  def new
    redirect_to User::Github.client.auth_code.authorize_url(:redirect_uri =>  User::Github.redirect_uri(request))
  end

  def create
    token = User::Github.client.auth_code.get_token(params[:code], :redirect_uri => User::Github.redirect_uri(request))
    token.client.site = 'https://api.github.com'
    if token and access_token = token.token
      if user = User.find_by_access_token(access_token)
        session[:user_id] = user.id
        redirect_to '/'
      elsif user = User::Github.create_user(token)
        session[:user_id] = user.id
        redirect_to '/'
      else
        render :text => "OOPS!"
      end

    else
      render :text => "OOPS!"
    end

  end

end
