class AuthenticationsController < ApplicationController

	def create
	  omniauth_auth = request.env['omniauth.auth']
	  if current_user
		current_user.authentications.create(provider: omniauth_auth[:provider], uid: omniauth_auth['uid'])
		_user = current_user
	  else
	    info = omniauth_auth['info']
		email = info[:email]

	  	_user = User.where(email: email).first

	  	unless _user
	  		ActiveRecord::Base.transaction do
	  			_random = 10.times.map{ 20 + Random.rand(11) }.join()
	  			_user = User.create!(email: email, password: _random, password_confirmation: _random)

	  			_user.authentications.create(provider: omniauth_auth[:provider], uid: omniauth_auth['uid'])
  			end
	  	end

	  end
	  flash[:notice] = 'Successfully logged in'
	  sign_in _user
	  redirect_to welcome_path
	end
end
