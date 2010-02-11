class Admin::PrincipalController < Admin::AdminController

	def index
		if !current_user
			redirect_to login_path
		end
	end
end
