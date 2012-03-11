class UserOmniauthCallbacksController < Devise::OmniauthCallbacksController
	def netflix
		info = request.env["omniauth.auth"]
		@user = User.find_for_netflix(info, current_user)

		flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Netflix"
		sign_in_and_redirect @user, :event => :authentication
	end
end
