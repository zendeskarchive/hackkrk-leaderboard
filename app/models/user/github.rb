class User
  module Github

    def self.client
      OAuth2::Client.new(Rails.configuration.github.token, Rails.configuration.github.secret, {
        :site => 'https://github.com/',
        :authorize_url => '/login/oauth/authorize',
        :token_url => '/login/oauth/access_token'
      })
    end

    def self.redirect_uri(request)
      port = request.port.to_i
      "#{request.scheme}://#{(port == 80 || port == 443) ? request.host : request.host_with_port }/oauth/github/callback"
    end

    def self.create_user(token_object)
      github_user = token_object.get('/user').parsed
      user = User.new({
        :username     => github_user['login'],
        :access_token => token_object.token,
        :avatar_url   => github_user['avatar_url'],
        :provider     => 'github'
      })
      user.save
      user
    end

  end
end
